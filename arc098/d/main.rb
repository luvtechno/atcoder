require 'set'
require 'pp'
N = gets.chomp.to_i
a = gets.chomp.split(" ").map(&:to_i)

ans = 0

l = r = 0
cur = 0
while l < N do
  # puts "l:#{l} r:#{r} ans:#{ans} cur:#{cur}"
  while r < N do
    flag = (cur ^ a[r]) != (cur + a[r])
    break if flag

    cur = cur ^ a[r]
    r += 1
    # puts "l:#{l} r:#{r} ans:#{ans} cur:#{cur}"
  end

  ans += r - l

  cur = cur ^ a[l]

  l += 1
end


puts ans
