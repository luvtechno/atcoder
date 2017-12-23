a, b, c, d = gets.chomp.split(" ").map(&:to_i)

x = a + b - c - d

if x == 0
  puts 'Balanced'
elsif x > 0
  puts 'Left'
else
  puts 'Right'
end
