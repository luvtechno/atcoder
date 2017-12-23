s = gets.chomp.chars
s = s.map { |e| e == '1' }

len = s.size
ret = len.downto(1).each do |i|
  sub_s = s[0..(i-1)]

  z = sub_s[0]
  if sub_s.all? { |e| e == z }
    break i
  end

  ((len - i)..(i-1)).each do |j|
    sub_s[j] = !sub_s[j]
  end
  z = sub_s[0]
  if sub_s.all? { |e| e == z }
    break i
  end
end

puts ret
