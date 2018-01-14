require 'pp'
q = gets.chomp.to_i

def solve
  ans = ""
  a, b, c, d = gets.chomp.split(" ").map(&:to_i)

  a_array = []
  b_array = []

  if a >= b || true
    max = (a + b) / (b + 1)

    loop do
      if a >= max
        a_array << max
        a -= max
      else
        a_array << a
        break
      end
    end
    a_array.reverse!

    loop do
      if b >= max
        b_array << max
        b -= max
      else
        b_array << b
        break
      end
    end

    pp a_array
    pp b_array

    loop do
      break if a_array.empty? && b_array.empty?
      aa = a_array.pop
      bb = b_array.pop

      ans += 'a' * aa unless aa.nil?
      ans += 'b' * bb unless bb.nil?
      pp ans
    end
  else
    b / a
  end

  puts ans[c+1..d+1]
end


q.times do
  solve
end
