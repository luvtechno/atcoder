k = gets.chomp.to_i
a = gets.chomp.split(" ").map(&:to_i).reverse


min = 2
max = 2
f = true

a.each do |x|
  if max - min < x
    f = false
    break
  end

  m = (min + x - 1) / x * x
  n = max / x * x + x - 1

  if m > max
    f = false
    break
  end

  if n < min
    f = false
    break
  end

  min = m
  max = n
end

if f
  puts "#{min} #{max}"
else
  puts -1
end
