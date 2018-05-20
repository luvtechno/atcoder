require 'pp'
N = gets.chomp.to_i
a = []
N.times do |i|
  x = gets.chomp.to_i
  a << x
end

failed = a[0] > 0
(0..N-2).each do |i|
  if a[i] + 1 < a[i+1]
    failed = true
    break
  end
end

if failed
  puts -1
  exit 0
end

cost = 0

i = 1
while i < N
  if a[i-1] + 1 == a[i]
    cost += 1
  else
    cost += a[i]
  end
  i += 1
end

puts cost
