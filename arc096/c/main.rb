require 'pp'
pa, pb, pc, x, y = gets.chomp.split(" ").map(&:to_i)

a, b, c = 0, 0, 0

min_total = x * pa + y * pb

(1..10**5*2).each do |hc|
  c = hc * 2
  a = [x - hc, 0].max
  b = [y - hc, 0].max
  total = a * pa + b * pb + c * pc

  if total < min_total
    min_total = total
  end
end


puts min_total
