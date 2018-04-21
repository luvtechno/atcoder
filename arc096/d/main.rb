require 'pp'
N, C = gets.chomp.split(" ").map(&:to_i)
x = []
v = []

N.times do |i|
  x[i], v[i] = gets.chomp.split(" ").map(&:to_i)
end

x_r = x.reverse
x_r.each_with_index do |e, i|
  x_r[i] = C - e
end
v_r = v.reverse

def costs(x, v)
  costs = []
  N.times do |i|
    d = i == 0 ? x[i] : x[i] - x[i-1]
    costs[i] = v[i] - d
  end
  costs
end

c = costs[x, v]
c_r = costs[x_r, v_r]


def max_e(x, v, c)
  answer = [0]

  e = 0
  c.each_eith_index do |c, i|
    e += c
    e_max = [e_max, e].max
    answer << e_max
  end

  answer
end


e_f = max_e(x, v)
e_r = max_e(x_r, v_r)


def solve(x, c, e_f, e_r)
  max_e = 0


end


max_e_f = solve(x, c, e_f, e_r)
max_e_r = solve(x_r, c_r, e_r, e_f)

puts [max_e_f, max_e_r].max
