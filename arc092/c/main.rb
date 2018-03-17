require 'pp'
n = gets.chomp.to_i

red = []
n.times do
  red << gets.chomp.split(" ").map(&:to_i)
end

blue = []
n.times do
  blue << gets.chomp.split(" ").map(&:to_i)
end

red.sort! do |x, y|
  y[0] <=> x[0]
end

blue.sort! do |x, y|
  y[0] <=> x[0]
end

pair = 0

q = []

loop do
  break if blue.empty?
  # pp pair, red, blue, q
  # puts

  if !red.empty? && red.last[0] < blue.last[0]
    r = red.pop
    q << r
    q.sort! do |x, y|
      y[1] <=> x[1]
    end
  else
    b = blue.pop
    index = nil
    q.each_with_index do |r, i|
      if r[1] < b[1]
        index = i
        pair += 1
        break
      end
    end
    q.delete_at(index) if index
  end
end

puts pair
