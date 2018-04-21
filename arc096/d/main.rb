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

  # costs2 = [costs[0]]
  # x2 = [x[0]]
  # (1..N-1).each do |i|
  #   if (costs[i-1] > 0 && costs[i] > 0) || (costs[i-1] <= 0 && costs[i] <= 0)
  #     costs2[-1] += costs[i]
  #     x2[-1] += x[i]
  #   else
  #     costs2 << costs[i]
  #     x2 << x[i]
  #   end
  # end

  # ans_e = 0
  # e = 0
  # ans_d = 0
  # costs2.each_with_index do |c, i|
  #   e += c

  #   if c > 0
  #     ans_e += c
  #     and_d = i
  #   else
  #     ans_e += c
  #     and_d = i

  #   end
  # end

  # [ans_e, x2[ans_d]]
end


e_f = max_e(x, v)
e_r = max_e(x_r, v_r)


def solve(x, c, e_f, e_r)
  max_e = 0


end


max_e_f = solve(x, c, e_f, e_r)
max_e_r = solve(x_r, c_r, e_r, e_f)

puts [max_e_f, max_e_r].max
