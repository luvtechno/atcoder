require 'pp'
N = gets.chomp.to_i
p = []
index = Array.new(N+1)
N.times do |i|
  x = gets.chomp.to_i
  p << x
  index[x] = i
end

max = 1

i = 1
while i <= N
  current = 1
  while i < N
    if index[i] < index[i+1]
      current += 1
      max = current if current > max
      i += 1
    else
      break
    end
  end
  i += 1
end

puts N - max
