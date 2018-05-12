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

# pp c, a

ans = 0

l = 0

b_next = 1
w_next = 1

while l < N2
  c_l = c[l]
  a_l = a[l]

  if c_l == nil
    l += 1
    next
  end

  if c_l == 'B' && b_next == a_l
    l += 1
    b_next += 1
    next
  end
  if c_l == 'W' && w_next == a_l
    l += 1
    w_next += 1
    next
  end

  move = 0
  r = l + 1
  while r < N2
    move += 1 if c[r] != nil
    if c[r] == 'B' && b_next == a[r]
      b_next += 1
      c[r] = nil
      break
    end
    if c[r] == 'W' && w_next == a[r]
      w_next += 1
      c[r] = nil
      break
    end
    r += 1
  end

  ans += move

  # l += 1
end

puts ans
