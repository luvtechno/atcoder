require 'pp'
N = gets.chomp.to_i
a = gets.chomp.split(" ").map(&:to_i)

ans = 0
hash = Hash.new(0)
N.times do |i|
  next_hash = Hash.new(0)
  x = a[i]
  hash.each do |k, v|
    next_hash[k + x] = v
  end
  next_hash[x] += 1
  ans += next_hash[0]
  hash = next_hash
  # pp hash
end

puts ans
