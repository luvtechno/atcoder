require 'set'
require 'pp'
N = gets.chomp.to_i
N2 = N * 2
c = []
a = []
N2.times do |i|
  x, y = gets.chomp.split(" ")
  c[i] = x
  a[i] = y.to_i
end

pp c, a

ans = 0

l = 0
while l < N2
  c_l = c[l]
  a_l = a[l]

  target = l
  r = l + 1
  while r < N2
    if c_l == c[r]
      if a_l > a[r]
        target = r
      end
    end
    r += 1
  end

  (l+1..target).each do |i|
    c[i-1] = c[i]
    a[i-1] = a[i]
  end
  c[target] = c_l
  a[target] = a_l

  move = target - l
  ans += move

  pp l, target, c, a

  if move == 0
    l += 1
  end
end

puts ans
