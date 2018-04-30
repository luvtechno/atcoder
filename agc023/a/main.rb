require 'pp'
N = gets.chomp.to_i
a = gets.chomp.split(" ").map(&:to_i)

ans = 0
hash = Hash.new(0)
sum = 0
N.times do |i|
  x = a[i]
  sum += x
  hash[x - sum] += 1
  ans += hash[-sum]
  # pp sum, hash
end

puts ans
