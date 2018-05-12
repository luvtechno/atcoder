require 'set'
require 'pp'
N = gets.chomp.split(" ").map(&:to_i)
c = []
a = []
(N*2).times do |i|
  x, y = gets.chomp.split(" ").map(&:to_i)
  c[i] = x
  a[i] = y
end

