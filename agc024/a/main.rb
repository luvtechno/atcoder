require 'pp'
a, b, c, k = gets.chomp.split(" ").map(&:to_i)

x = a - b
if x > 10 ** 18 || x < - (10 ** 18)
  puts 'Unfair'
elsif k.even?
  puts x
else
  puts -x
end
