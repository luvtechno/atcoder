require 'pp'
require 'set'
N = gets.chomp.to_i

edges = Array.new(N) { Set.new }

(N-1).times do |i|
  a, b = gets.chomp.split(" ").map(&:to_i)
  a -= 1
  b -= 1
  s = edges[a]
  s << b
  edges[a] = s

  s = edges[b]
  s << a
  edges[b] = s
end

def depth(s, i, edges)
  s = s.dup
  s << i
  nodes = edges[i]
  depth_list = []
  nodes.each do |j|
    next if s.include?(j)
    depth_list << depth(s, j, edges)
  end
  if depth_list.empty?
    1
  else
    depth_list.max + 1
  end
end


min_nodes = Set.new
min = N
N.times do |i|
  s = Set.new
  s << i

  d = depth(s, i, edges)
  if min > d
    min_nodes = Set.new
    min_nodes << i
    min = d
  elsif min == d
    min_nodes << i
  end
  # pp [i, d]
end

# pp min
# pp min_nodes.to_a
