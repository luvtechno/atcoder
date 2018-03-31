s = 10
loop do
  s += 1
  if s % 2 == 0 && s % 3 == 0 && s % 5 == 0
    break
  end
end
puts s

# 2, 3, 25
# 30
# 14 16
#  8 10 12
#  4  6  8 12
#  2  4  6  8 10
