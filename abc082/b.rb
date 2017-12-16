a = gets.chomp
b = gets.chomp

o = nil

a = a.chars.sort
b = b.chars.sort.reverse

(0..(a.size-1)).each do |i|
  if a[i] > b[i]
    o = false
    break
  elsif a[i] < b[i]
    o = true
    break
  end
end

if o.nil?
  if a.size == b.size
    o = false
  else
    o = true
  end
end

if o
  puts 'Yes'
else
  puts 'No'
end
