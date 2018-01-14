# require 'pp'
@n = gets.chomp.to_i
@a = gets.chomp.split(" ").map(&:to_i)

@s = []

def f(i, sum)
  if i == @n
    @s << sum
    return
  end

  f(i + 1, sum)
  f(i + 1, sum + @a[i])
end

f(0, 0)

@s.sort!
# pp @s
puts @s[2 ** (@n - 1)]
