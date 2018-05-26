require 'set'
require 'pp'
N = gets.chomp.to_i
a = gets.chomp.split(" ").map(&:to_i)


bits = Array.new(N) { Array.new(20, false) }
N.times do |i|
  x = a[i]
  20.times do |j|
    bits[i][j] = x % 2 == 1
    x /= 2
  end
end

# pp bits

ans = 0

l = r = 0
while l < N do
  cur = bits[l].dup
  while r < N do
    if l == r
      ans += 1
    else
      flag = false
      20.times do |j|
        if bits[r][j]
          if cur[j]
            flag = true
          else
            cur[j] = true
          end
        end
      end
      if flag
        break
      else
        ans += 1
      end
    end
    r += 1
  end

  l += 1
  r = l
end


puts ans
