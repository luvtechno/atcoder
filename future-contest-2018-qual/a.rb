# require 'pp'
# require 'rblineprof'
START_TIME = Time.new
TIME_LIMIT = (ARGV[0] || 5.95).to_f
# GC.disable

N = 100

class F < Struct.new(:mat, :score)
  def initialize(mat, score)
    if score.nil?
      score = 0
      mat.each do |row|
        row.each do |e|
          score += e.abs
        end
      end
    end
    super(mat, score)
  end

  def sub(x, y, h)
    old_score = self.score
    penalty = 0
    ([x-h+1, 0].max..[x+h-1, N-1].min).each do |i|
      ([y-h+1, 0].max..[y+h-1, N-1].min).each do |j|
        d = h - (x - i).abs - (y - j).abs
        next if d <= 0
        old_value = self.mat[j][i]
        new_value = old_value - d
        self.mat[j][i] = new_value
        score_diff = old_value.abs - new_value.abs
        self.score -= score_diff
        penalty += d if new_value < 0 && old_value >= 0
      end
    end
    old_score - self.score - penalty * 3
  end

  def max
    max = mat[0][0]
    max_x = max_y = 0
    mat.each_with_index do |row, y|
      row.each_with_index do |e, x|
        if max < e
          max = e; max_x = x; max_y = y
        end
      end
    end
    [max, max_x, max_y]
  end

  def dup
    mat_dup = []
    mat.each { |row| mat_dup << row.dup }
    f = F.new(mat_dup, self.score)
  end

  def print
    mat.each { |row| puts row.join(' ') }
  end
end

class Seq < Struct.new(:arr, :target)
  def initialize(target)
    super([], target.dup)
  end

  def dup
    seq = Seq.new(target)
    seq.arr = arr.dup
    seq
  end

  def add!(x, y, h, score_target)
    # raise if h <= 0 || h > N
    next_target = target.dup
    score_diff = next_target.sub(x, y, h)
    if score_diff >= score_target
      self.target = next_target
      arr << [x, y, h]
    end
  end

  def score
    target.score
  end

  SCORE_TARGET_MEMO = {}
  def score_target(h)
    memo = SCORE_TARGET_MEMO[h]
    return memo if memo

    a = [0]
    (1..h).each do |b|
      a[b] = a[b-1] + (b * 2 - 1)
    end
    score_target = a.reduce(&:+) * 2 - a[-1]

    SCORE_TARGET_MEMO[h] = score_target
    score_target
  end

  def greedy
    250.times do
      break if (elapsed = Time.now - START_TIME) > TIME_LIMIT
      x = rand(N); y = rand(N); h = N
      add!(x, y, h, 1)
    end

    prev_score = score
    h_cap = N
    i = 0
    loop do
      break if (elapsed = Time.now - START_TIME) > TIME_LIMIT

      h, x, y = target.max
      h2 = [h, h_cap].min
      if h > 0
        s_target = score_target(h2)
        add!(x, y, h2, s_target / 2)
      end

      # STDERR.puts "t:#{elapsed} i:#{i} score:#{score}, h_cap:#{h_cap}, h2:#{h2} h:#{h}, x:#{x}, y:#{y}"
      if prev_score == score
        h_cap = (h2 + 1) / 2
        break if h_cap <= 0
      else
        h_cap = [[h, 100].min, 1].max
      end
      prev_score = score
      i += 1
      break if arr.size >= 1000
    end
  end

  def print
    puts arr.size
    arr.each do |x, y, h|
      puts "#{x} #{y} #{h}"
    end
  end
end

def solve(target)
  elapsed = Time.now - START_TIME
  best_score = 200000000
  best_seq = nil

  loop do
    seq = Seq.new(target)
    seq.greedy

    if seq.score < best_score
      best_score = seq.score
      best_seq = seq
    end

    break if (elapsed = Time.now - START_TIME) > TIME_LIMIT
    STDERR.puts "t:#{elapsed} best:#{best_score} score:#{seq.score}"
  end
  STDERR.puts "t:#{elapsed} best:#{best_score} best_step:#{best_seq.arr.size}"

  best_seq
end

target_mat = []
N.times do
  target_mat << STDIN.gets.chomp.split(" ").map(&:to_i)
end
target = F.new(target_mat, nil)

seq = nil
# profile = lineprof(/./) do
  seq = solve(target)
# end
# file = profile.keys.first
# File.readlines(file).each_with_index do |line, num|
#   wall, cpu, calls, allocations = profile[file][num + 1]

#   if wall > 0 || cpu > 0 || calls > 0
#     printf(
#       "% 5.1fms + % 6.1fms (% 4d) | %s",
#       cpu / 1000.0,
#       (wall - cpu) / 1000.0,
#       calls,
#       line
#     )
#   else
#     printf "                          | %s", line
#   end
# end

seq.print
