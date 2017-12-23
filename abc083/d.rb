s = gets.chomp.chars
s = s.map { |e| e == '1' }

len = s.size
ret = len

pos = []
z = s[0]

left_len = 0
loop do
  break if left_len == len
  if s[left_len] != z
    ret = [left_len, len - left_len].max
    (left_len..(len-1)).each do |j|
      s[j] = !s[j]
    end
  else
    left_len += 1
  end
end

puts ret
