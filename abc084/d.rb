require 'prime'

q = gets.chomp.to_i

ls = []
rs = []
a = Array.new(10 ** 5, nil)
b = Array.new(10 ** 5, nil)
c = Array.new(10 ** 5, 0)
max = 0

q.times do
  l, r = gets.chomp.split(" ").map(&:to_i)
  ls << l
  rs << r
  max = r if r > max
end

Prime.each(max).each { |prime| a[prime] = true }

(1..max).each do |i|
  b[i] = a[i] && a[(i+1)/2]
end

(1..max).each do |i|
  c[i] = c[i-1]
  c[i] += 1 if b[i]
end

q.times do |i|
  l = ls[i]
  r = rs[i]
  puts c[r] - c[l-1]
end
