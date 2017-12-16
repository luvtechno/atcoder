a = gets.chomp
b = gets.chomp

o = nil

a = a.chars.sort
b = b.chars.sort.reverse

len = 0
if a.size > b.size
  len = b.size - 1
else
  len = a.size - 1
end

(0..len).each do |i|
  if a[i] > b[i]
    o = false
    break
  elsif a[i] < b[i]
    o = true
    break
  end
end

if o.nil?
  if a.size < b.size
    o = true
  else
    o = false
  end
end

if o
  puts 'Yes'
else
  puts 'No'
end
