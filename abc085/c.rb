n, y = gets.chomp.split(" ").map(&:to_i)
x = y / 1000 - n

# a + b + c = n
# 10 * a + 5 * b + c = y / 1000
# 9 * a + 4 * b = y / 1000 - n

a = b = c = -1
a_max = x / 9
(0..a_max).each do |i|
  j = x - 9 * i
  break if j < 0
  k = j / 4
  if k * 4 == j && n - i - k >= 0
    a = i
    b = k
    break
  end
end

if a != -1
  c = n - a - b
end

puts "#{a} #{b} #{c}"

