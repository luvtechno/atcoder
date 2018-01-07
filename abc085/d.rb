n, h = gets.chomp.split(" ").map(&:to_i)
a = []
b = []
n.times do |i|
  a[i], b[i] = gets.chomp.split(" ").map(&:to_i)
end

c = 0

a_max = a.max
b_sorted = b.sort.reverse
b_sorted.each do |x|
  break if x <= a_max
  h -= x
  c += 1
  break if h <= 0
end

if h > 0
  c += (h + a_max - 1)/ a_max
end

puts c
