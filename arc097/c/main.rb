require 'pp'
s = gets.chomp
K = gets.chomp.to_i

ans = []

a = 0
b = 0
len = s.size

while a < len
  b = a
  while b < a + 5 && b < len
    str = s[a..b]
    if ans.include?(str)
      # nop
    elsif ans.size < K
      ans << str
      ans.sort!
    else
      if ans[-1] < str
        break
      else
        ans << str
        ans.sort!
        ans.pop
      end
    end
    b += 1
  end
  a += 1
end

# puts ans

puts ans[K-1]
