require 'pp'
n = gets.chomp.to_i

def fact(x)
  (1..x).reduce(1) do |z, x|
    (z % 100000007) * (x % 100000007)
  end
end

puts  (fact(n) % 100000007)* (fact(n - 1) % 100000007)
