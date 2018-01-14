k = gets.chomp.to_i
a = gets.chomp.split(" ").map(&:to_i).reverse


min = 2
max = 2
f = true

a.each do |x|
  n_min = (min + x - 1) / x * x
  n_max = max / x * x + (x - 1)

  v_min = n_min / x * x
  v_max = n_max / x * x

  if v_min >= min && v_min <= max && v_max >= min && v_max <= max
    min = n_min
    max = n_max
  else
    f = false
  end
  # puts "#{x} #{min} #{max}"
end

if f
  puts "#{min} #{max}"
else
  puts -1
end
