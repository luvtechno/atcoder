n = gets.chomp.to_i
d = []
n.times do
  d << gets.chomp.to_i
end
d.sort!
c = 1
(n-1).times do |i|
  c += 1 if d[i] < d[i+1]
end
puts c
