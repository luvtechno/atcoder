require 'pp'
N = gets.chomp.to_i
a_list = []
b_list = []
(N-1).times do |i|
  a, b = gets.chomp.split(" ").map(&:to_i)
  a_list << a
  b_list << b
end
