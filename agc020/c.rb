# require 'pp'
n = gets.chomp.to_i
a = gets.chomp.split(" ").map(&:to_i)

s = []

q = []
q << [0, 0]

loop do
  break if q.empty?
  i, sum = q.pop
  if i == n
    s << sum
  else
    q << [i + 1, sum]
    q << [i + 1, sum + a[i]]
  end
end


s.sort!
# pp s
puts s[2 ** (n - 1)]
