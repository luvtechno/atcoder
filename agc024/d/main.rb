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
min_depth = N
N.times do |i|
  s = Set.new
  s << i

  d = depth(s, i, edges)
  if min_depth > d
    min_nodes = Set.new
    min_nodes << i
    min_depth = d
  elsif min_depth == d
    min_nodes << i
  end
  # pp [i, d]
end

# pp min_depth
# pp min_nodes.to_a

min_color_count = N
min_leaf_count = 10 ** 10

def child_count(s, i, edges, depth_count_max, depth)
  s = s.dup
  s << i
  nodes = edges[i]
  nodes = nodes - s
  size = nodes.size
  depth_count_max[depth] = size if depth_count_max[depth] < size
  nodes.each do |j|
    child_count(s, j, edges, depth_count_max, depth + 1)
  end
end

min_nodes.each do |i|
  depth_count_max = Array.new(min_depth, 1)
  depth_count_max[0] = 0
  s = Set.new
  s << i
  child_count(s, i, edges, depth_count_max, 0)
  # pp i
  # pp edges
  # pp depth_count_max

  leaf_count = depth_count_max.reduce(:*)
  color_count = min_depth

  if min_leaf_count > leaf_count
    min_leaf_count = leaf_count
    min_color_count = color_count
  end

  ##

  s = Set.new
  s << i
  nodes = edges[i]
  nodes.each do |j|
    depth_count_max = Array.new(min_depth, 1)
    s2 = s.dup
    s2 << j
    child_count(s2, i, edges, depth_count_max, 0)
    child_count(s2, j, edges, depth_count_max, 0)
    leaf_count = depth_count_max.reduce(:*) * 2
    d1 = depth(s2, i, edges)
    d2 = depth(s2, j, edges)
    color_count = [d1, d2].max

    if min_color_count > color_count
      min_leaf_count = leaf_count
      min_color_count = color_count
    elsif min_color_count == color_count && min_leaf_count > leaf_count
      min_leaf_count = leaf_count
      min_color_count = color_count
    end

  end


end


puts "#{min_color_count} #{min_leaf_count}"
