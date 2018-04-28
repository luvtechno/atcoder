require 'pp'
N = gets.chomp.to_i
a = gets.chomp.split(" ").map(&:to_i)

ans = 0

N.times do |i|
  sum = 0
  (i..N-1).each do |j|
    sum += a[j]
    ans += 1 if sum == 0
  end
end

puts ans
