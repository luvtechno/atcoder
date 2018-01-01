require 'prime'
instance = Prime.instance

q = gets.chomp.to_i

q.times do
  l, r = gets.chomp.split(" ").map(&:to_i)

  count = 0
  (l..r).step(2) do |n|
    count += 1 if instance.prime?(n) && instance.prime?((n+1)/2)
  end
  puts count
end

