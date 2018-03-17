require 'pp'
n = gets.chomp.to_i
a = gets.chomp.split(" ").map(&:to_i)


count = 0
q = []

loop do
  break if a.size == 1
  pp a

  b = []
  last_i = a.size - 1
  a.each_with_index do |e, i|
    if i == 0
      b[i] = -e
    elsif i == last_i
      b[i] = -e
    else
      b[i] = a[i - 1] + a[i + 1] - e
    end
  end

  pp b
  puts

  max = b[0]
  max_index = 0

  b.each_with_index do |e, i|
    if e > max
      max = e
      max_index = i
    end
  end

  if max_index == 0 || max_index == a.size - 1
    a.delete_at(max_index)
  else
    a[max_index] = a[max_index - 1] + a[max_index + 1]
    a.delete_at(max_index + 1)
    a.delete_at(max_index - 1)
  end

  count += 1
  q << max_index + 1
end

puts a[0]
puts count
q.each { |e| puts e }
