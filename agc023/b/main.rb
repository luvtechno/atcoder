require 'pp'
N = gets.chomp.to_i
m = []
N.times do
  m << gets.chomp.chars
end

def good(m, a, b)
  N.times do |i|
    N.times do |j|
      return false if m[(i+a)%N][(j+b)%N] != m[(j+a)%N][(i+b)%N]
    end
  end
  true
end

ans = 0
N.times do |a|
  N.times do |b|
    ans += 1 if good(m, a, b)
  end
end

puts ans
