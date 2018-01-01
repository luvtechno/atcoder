require 'prime'
instance = Prime.instance

q = gets.chomp.to_i

ls = []
rs = []
a = Array.new(10 ** 5, nil)
max = 0

q.times do
  l, r = gets.chomp.split(" ").map(&:to_i)
  ls << l
  rs << r
  max = r if r > max
end

Prime.each(max).each { |prime| a[prime] = true }

q.times do |i|
  l = ls[i]
  r = rs[i]
  count = 0
  (l..r).step(2) do |n|
    count += 1 if a[n] && a[(n+1)/2]
  end
  puts count
end
