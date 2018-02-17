# require 'pp'
START_TIME = Time.new
TIME_LIMIT = (ARGV[0] || 5.6).to_f
STEPS = (ARGV[1] || 450).to_i
# GC.disable

N = 100

class F < Struct.new(:mat)
  def add(x, y, h)
    ([x-h+1, 0].max..[x+h-1, N-1].min).each do |i|
      ([y-h+1, 0].max..[y+h-1, N-1].min).each do |j|
        mat[j][i] += [h - (x - i).abs - (y - j).abs, 0].max
      end
    end
  end

  def print
    mat.each { |row| puts row.join(' ') }
  end
end

class Seq < Struct.new(:arr, :score, :target)
  def gen_rand!(steps = 1000)
    steps.times do
      x = rand(N)
      y = rand(N)
      h = 1 + rand(N - 1)
      arr << [x, y, h]
    end
  end

  def gen_rand2!(steps = 1000)
    250.times do
      x = rand(N)
      y = rand(N)
      h = N
      arr << [x, y, h]
    end

    (steps - 250).times do
      x = rand(N)
      y = rand(N)
      h = 1 + rand(N - 1)
      arr << [x, y, h]
    end
  end

  def print
    puts arr.size
    arr.each do |x, y, h|
      puts "#{x} #{y} #{h}"
    end
  end

  def calc_score
    a = Array.new(N) { Array.new(N, 0) }
    f = F.new(a)
    arr.each do |x, y, h|
      break if (elapsed = Time.now - START_TIME) > TIME_LIMIT
      f.add(x, y, h)
    end

    self.score = 200000000
    N.times do |j|
      N.times do |i|
        # puts "#{j} #{i}: #{target.mat[j][i]} #{f.mat[j][i]}"
        self.score -= (target.mat[j][i] - f.mat[j][i]).abs
      end
    end
  end
end

def solve(target)
  best_score = 0
  best_seq = nil

  loop do
    break if (elapsed = Time.now - START_TIME) > TIME_LIMIT
    STDERR.puts "t:#{elapsed} score:#{best_score}"

    seq = Seq.new([], 0, target)
    seq.gen_rand2!(STEPS)
    seq.calc_score

    if seq.score > best_score
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
