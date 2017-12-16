n = gets.chomp.to_i
a = gets.chomp.split(" ").map(&:to_i)

hash = Hash.new(0)

a.each do |e|
  hash[e] += 1
end

ans = 0

hash.each do |k, v|
  if v > k
    ans += v - k
  elsif v < k
    ans += v
  end
end

puts ans
