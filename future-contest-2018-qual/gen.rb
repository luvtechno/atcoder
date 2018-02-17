require 'pp'
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

a = Array.new(N) { Array.new(N, 0) }

f = F.new(a)

N.times do
  x = rand(N)
  y = rand(N)
  h = rand(N)

  f.add(x, y, h)
end

f.print
