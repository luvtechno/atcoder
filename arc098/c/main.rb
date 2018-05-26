require 'set'
require 'pp'
N = gets.chomp.to_i
s = gets.chomp

e_count = 0
w_count = 0
(0..N-1).each do |i|
  e_count += 1 if s[i] == 'E'
end

ans = N

N.times do |i|
  e_count -= 1 if s[i] == 'E'
  w_count += 1 if i > 0 && s[i-1] == 'W'
  ans = e_count + w_count if ans > e_count + w_count
end

puts ans
