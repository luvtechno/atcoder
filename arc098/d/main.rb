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
ans_l = 0
while l < N do
  cur = bits[l].dup
  # puts "l:#{l} r:#{r} ans_l:#{ans_l} ans:#{ans} cur:#{cur}"
  while r < N do
    if l == r
      ans_l += 1
    else
      flag = false
      21.times do |j|
        if bits[r][j] == 1 && cur[j] == 1
          flag = true
        end
      end

      if flag
        r -= 1
        break
      else
        21.times do |j|
          if bits[r][j] == 1
            cur[j] = 1
          end
        end
        ans_l += 1
      end
    end
    r += 1
    # puts "l:#{l} r:#{r} ans_l:#{ans_l} ans:#{ans} cur:#{cur}"
  end

  # puts "l:#{l} r:#{r} ans_l:#{ans_l} ans:#{ans} cur:#{cur}"

  r -= 1 if r >= N
  ans += r - l + 1
  # ans += ans_l
  # ans_l -= 1

  21.times do |j|
    if bits[l][j] == 1
      cur[j] = 0
    end
  end

  l += 1
  if r < l
    r = l
  end
end


puts ans
