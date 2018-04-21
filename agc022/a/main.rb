require 'pp'
s = gets.chomp
c = s.chars
all = "abcdefghijklmnopqrstuvwxyz".chars
rest = all - c


if rest.size > 0
  puts s + rest[0]
else
  buf = []
  loop do
    d = c.pop
    buf << d
    buf.sort!

    break if c.size == 0

    if c.last < buf.last
      t = buf[0]
      buf.each do |e|
        if c.last < e
          t = e
          break
        end
      end
      c[-1] = t
      break
    end
  end
  if c.size == 0
    puts -1
  else
    puts c.join
  end
end
