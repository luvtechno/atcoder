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
pos = Array.new(N)
check = Array.new(N, false)

