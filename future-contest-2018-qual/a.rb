# require 'pp'
START_TIME = Time.new
TIME_LIMIT = (ARGV[0] || 5.8).to_f
STEPS = (ARGV[1] || 500).to_i
# GC.disable

N = 100

class F < Struct.new(:mat, :score)
  def initialize(mat)
    s = 0
    max_x = 0; max_y = 0; max = 0
    mat.each_with_index do |row, y|
      row.each_with_index do |e, x|
        s += e.abs
      end
    end
    super(mat, s)
  end

  def sub(x, y, h)
    old_score = self.score
    ([x-h+1, 0].max..[x+h-1, N-1].min).each do |i|
      ([y-h+1, 0].max..[y+h-1, N-1].min).each do |j|
        d = [h - (x - i).abs - (y - j).abs, 0].max
        old_value = self.mat[j][i]
        new_value = old_value - d
        self.mat[j][i] = new_value
        score_diff = old_value.abs - new_value.abs
        self.score -= score_diff
      end
    end
    old_score - self.score
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
    f = F.new(mat_dup)
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

  def add!(x, y, h)
    raise if h <= 0 || h > N
    arr << [x, y, h]
    target.sub(x, y, h)
  end

  def score
    target.score
  end

  def gen_rand2!(steps = 1000)
    (steps - 250).times do
      break if (elapsed = Time.now - START_TIME) > TIME_LIMIT

      x = rand(N)
      y = rand(N)
      h = 1 + rand(N - 1)
      add!(x, y, h)
    end
  end

  def greedy(steps = 1000)
    (steps - 250).times do
      break if (elapsed = Time.now - START_TIME) > TIME_LIMIT

      h, x, y = target.max
      if h > 0
        add!(x, y, [h, 100].min)
      end

      STDERR.puts "t:#{elapsed} score:#{score}"
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
  best_score = 200000000
  best_seq = nil

  base_seq = Seq.new(target)
  250.times do
    x = rand(N); y = rand(N); h = N
    base_seq.add!(x, y, h)
  end

  loop do
    break if (elapsed = Time.now - START_TIME) > TIME_LIMIT

    seq = base_seq.dup
    # seq.gen_rand2!(STEPS)
    seq.greedy(STEPS)

    if seq.score < best_score
      best_score = seq.score
      best_seq = seq
    end

    STDERR.puts "t:#{elapsed} best:#{best_score} score:#{seq.score}"
    break
  end

  best_seq
end

target_mat = []
N.times do
  target_mat << STDIN.gets.chomp.split(" ").map(&:to_i)
end
target = F.new(target_mat)

seq = solve(target)
seq.print
