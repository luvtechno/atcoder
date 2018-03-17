require 'pp'
n = gets.chomp.to_i
a = gets.chomp.split(" ").map(&:to_i)
b = gets.chomp.split(" ").map(&:to_i)

a_bits = Array.new(28, 0)
b_bits = Array.new(28, 0)
bits = Array.new(29, 0)


a.each do |e|
  index = 0
  loop do
    break if e == 0
    d = e % 2
    if d == 1
      a_bits[index] += 1
    end
    e /= 2
    index += 1
  end
end

b.each do |e|
  index = 0
  loop do
    break if e == 0
    d = e % 2
    if d == 1
      b_bits[index] += 1
    end
    e /= 2
    index += 1
  end
end

28.times do |i|
  up = a_bits[i] * b_bits[i]
  bits[i] += a_bits[i] * (n - b_bits[i]) + (n - a_bits[i]) * b_bits[i]
  bits[i + 1] += up
end

pp a_bits, b_bits, bits

answer = 0

29.times do |i|
  b = bits[i]
  if b % 2 == 1
    answer += 2 ** i
  end
end

puts answer
