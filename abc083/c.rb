x, y = gets.chomp.split(" ").map(&:to_i)

count = 0

loop do
  count += 1
  x *= 2
  break if x > y
end

puts count

