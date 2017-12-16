s = gets.chomp.chars
x, y = gets.chomp.split(" ").map(&:to_i)

x_steps = []
y_steps = [y.abs]

x_first_move = true

x_move = true
f_count = 0

s << "T"
s.size.times do |i|
  if s[i] == "F"
    f_count += 1
  else
    if x_move
      if x_first_move
        x_steps << (x - f_count).abs
        x_first_move = false
      else
        x_steps << f_count
      end
    else
      y_steps << f_count
    end

    x_move = !x_move
    f_count = 0
  end
end

# pp s
# pp x, y
# pp x_steps
# pp y_steps

def f(steps, r, i)
  return true if r == 0
  return false if r < 0

  return false if i >= steps.size

  return true if f(steps, r - steps[i], i + 1)
  return true if f(steps, r, i + 1)
  false
end




def solve?(steps)
  # sum = steps.sum
  sum = 0
  steps.each do |s|
    sum += s
  end

  return false if sum.odd?
  half = sum / 2

  steps = steps.sort.reverse
  # f(steps, half, 0)
  size = steps.size

  dp = Array.new(size + 1) { Array.new(half + 1) }
  (half + 1).times do |j|
    dp[0][j] = (j == 0)
  end

  (size + 1).times do |i|
    next if i == 0
    (half + 1).times do |j|
      if dp[i-1][j]
        dp[i][j] = true
      else
        if j >= steps[i-1]
          dp[i][j] = dp[i-1][j-steps[i-1]]
        else
          dp[i][j] = false
        end
      end
    end
  end
  dp[-1][-1]
end


solved = solve?(x_steps) && solve?(y_steps)
if solved
  puts "Yes"
else
  puts "No"
end
