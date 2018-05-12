require 'pp'
N, M = gets.chomp.split(" ").map(&:to_i)
p = gets.chomp.split(" ").map(&:to_i)
x = []
y = []
M.times do |i|
  x[i], y[i] = gets.chomp.split(" ").map(&:to_i)
end

pp x
