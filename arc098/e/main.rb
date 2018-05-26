def binary_search(array, item)
  first = 0
  last = array.length - 1

  while first <= last
    i = (first + last) / 2

    if array[i] == item
        return i
    elsif array[i] > item
        last = i - 1
    elsif array[i] < item
        first = i + 1
    else
        return nil
    end
  end
end

require 'set'
require 'pp'
N, K, Q = gets.chomp.split(" ").map(&:to_i)
a = gets.chomp.split(" ").map(&:to_i)

b = a.sort

min = b[Q-1] - b[0]

(1..N-Q-K).each do |i|
  target_min = b[i+Q-1] - b[i]
  success = false

  x = b[i]
  s = Set.new
  (0..i).each do |j|
    s << b[j]
  end

  l = l_pos = 0
  r = r_pos = N - 1


  while l < N
    break if a[l] == x
    if s.delete?(a[l])
      l_pos = l
    end
    l += 1
  end

  while r >= 0
    break if a[r] == x
    if s.delete?(a[r])
      r_pos = r
    end
    r -= 1
  end

  if s.empty? && (l_pos + N - r_pos) < N - Q - K
    success = true
  end

  min = target_min if success && target_min < min
end

puts min
