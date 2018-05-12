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

  target = l
  r = l + 1
  while r < N2
    if c[r] == 'B' && b_next == a[r]
      target = r
      b_next += 1
      break
    end
    if c[r] == 'W' && w_next == a[r]
      target = r
      w_next += 1
      break
    end
    r += 1
  end

  c_target = c[target]
  a_target = a[target]

  (l..target-1).reverse_each do |i|
    c[i+1] = c[i]
    a[i+1] = a[i]
  end
  c[l] = c_target
  a[l] = a_target

  move = target - l
  ans += move

  # pp l, target, c, a

  l += 1
end

puts ans
