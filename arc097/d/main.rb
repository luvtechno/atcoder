require 'set'
require 'pp'
N, M = gets.chomp.split(" ").map(&:to_i)
p = gets.chomp.split(" ").map(&:to_i)
N.times do |i|
  p[i] -= 1
end
x = []
y = []
M.times do |i|
  a, b = gets.chomp.split(" ").map(&:to_i)
  x[i] = a - 1
  y[i] = b - 1
end

## union find tree

par = (0..N-1).to_a
def root(par, a)
  if par[a] == a
    a
  else
    par[a] = root(par, par[a])
  end
end
def same_group?(par, x, y)
  root(par, x) == root(par, y)
end
def unite(par, a, b)
  a = root(par, a)
  b = root(par, b)
  return if a == b
  par[a] = b
end

M.times do |i|
  unite(par, x[i], y[i])
end

# pp par

##

index_hash = Hash.new { Set.new }
value_hash = Hash.new { Set.new }
N.times do |i|
  root = root(par, p[i])
  index_set = index_hash[root]
  value_set = value_hash[root]
  index_set << i
  value_set << p[i]
  index_hash[root] = index_set
  value_hash[root] = value_set
end

# pp index_hash
# pp value_hash

ans = 0
index_hash.each do |root, index_set|
  hash_set = value_hash[root]
  ans += index_set.intersection(hash_set).size
end

puts ans
