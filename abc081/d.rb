n = gets.to_i
a = gets.split(' ').map(&:to_i)

m = 0
ans = []

min = a.min
min_i = a.find_index(min)
max = a.max
max_i = a.find_index(max)

positive = max >= -min

if positive
  (1..(a.size-1)).each do |i|
    loop do
      break if a[i-1] <= a[i]
      a[i] += a[max_i]
      ans << [max_i, i]
      m += 1

      if max < a[i]
        max = a[i]
        max_i = i
      end
    end
  end
else
  (0..(a.size-2)).reverse_each do |i|
    loop do
      break if a[i+1] >= a[i]
      a[i] += a[min_i]
      ans << [min_i, i]
      m += 1

      if min > a[i]
        min = a[i]
        min_i = i
      end
    end
  end
end


puts m
ans.each do |a|
  puts "#{a[0]+1} #{a[1]+1}"
end

