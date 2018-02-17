# require 'pp'
START_TIME = Time.new
TIME_LIMIT = (ARGV[0] || 5.6).to_f
STEPS = (ARGV[1] || 450).to_i
# GC.disable

N = 100

class F < Struct.new(:mat, :sum)
  def initialize(mat)
    s = 0
    mat.each { |row| row.each { |e| s += e } }
    super(mat, s)
  end

  def sub(x, y, h)
    ([x-h+1, 0].max..[x+h-1, N-1].min).each do |i|
      ([y-h+1, 0].max..[y+h-1, N-1].min).each do |j|
        d = [h - (x - i).abs - (y - j).abs, 0].max
        self.mat[j][i] -= d
        self.sum -= d
      end
    end
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
  def add!(x, y, h)
    arr << [x, y, h]
    target.sub(x, y, h)
  end

  def score
    target.sum.abs
  end

  def gen_rand!(steps = 1000)
    steps.times do
      break if (elapsed = Time.now - START_TIME) > TIME_LIMIT

      x = rand(N)
      y = rand(N)
      h = 1 + rand(N - 1)
      add!(x, y, h)
    end
  end

  def gen_rand2!(steps = 1000)
    250.times do
      break if (elapsed = Time.now - START_TIME) > TIME_LIMIT

      x = rand(N)
      y = rand(N)
      h = N
      add!(x, y, h)
    end

    (steps - 250).times do
      break if (elapsed = Time.now - START_TIME) > TIME_LIMIT

      x = rand(N)
      y = rand(N)
      h = 1 + rand(N - 1)
      add!(x, y, h)
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

  loop do
    break if (elapsed = Time.now - START_TIME) > TIME_LIMIT
    STDERR.puts "t:#{elapsed} score:#{best_score}"

    seq = Seq.new([], target)
    seq.gen_rand2!(STEPS)

    if seq.score < best_score
      best_score = seq.score
      best_seq = seq
    end
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
