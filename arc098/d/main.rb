require 'set'
require 'pp'
N = gets.chomp.to_i
a = gets.chomp.split(" ").map(&:to_i)


bits = Array.new(N) { Array.new(21, 0) }
N.times do |i|
  x = a[i]
  21.times do |j|
    bits[i][j] = x % 2
    x /= 2
  end
  # pp [i, bits[i]]
end


ans = 0

l = r = 0
cur = Array.new(21, 0)
while l < N do
  # puts "l:#{l} r:#{r} ans:#{ans} cur:#{cur}"
  while r < N do
    flag = false
    21.times do |j|
      if bits[r][j] == 1 && cur[j] == 1
        flag = true
      end
    end
    break if flag

    21.times do |j|
      if bits[r][j] == 1
        cur[j] = 1
      end
    end

    r += 1
    # puts "l:#{l} r:#{r} ans:#{ans} cur:#{cur}"
  end

  ans += r - l

  21.times do |j|
    if bits[l][j] == 1
      cur[j] = 0
    end
  end

  l += 1
end


puts ans
