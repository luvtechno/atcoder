n, a, b = gets.chomp.split(" ").map(&:to_i)

if (b - a).odd?
  puts 'Borys'
else
  puts 'Alice'
end
