require 'pp'
N = gets.chomp.to_i
m = []
good_m = []
N.times do
  m << gets.chomp.chars
  good_m << Array.new(N)
end


N.times do |i|
  N.times do |j|
    v = 0
    (1..N-1).each do |k|
      break if m[(i+k)%N][j] != m[i][(j+k)%N]
      v += 1
    end
    good_m[i][j] = v
  end
end

# pp good_m

ans = 0
N.times do |i|
  N.times do |j|
    good = true
    N.times do |k|
      unless good_m[(i+k)%N][(j+k)%N] >= N - 1 - k
        good = false
        break
      end
    end
    ans += 1 if good
  end
end


puts ans
