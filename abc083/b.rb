n, a, b = gets.chomp.split(" ").map(&:to_i)


result = 0

(1..n).each do |i|
  sum = 0
  j = i
  loop do
    break if i == 0
    sum += i % 10
    i /= 10
  end
  if sum >= a && sum <= b
    result += j
  end
end

puts result
