require 'pp'

def max_index(a)
  max = a[0]
  max_i = 0

  a.each_with_index do |e, i|
    if e > max
      max = e
      max_i = i
    end
  end
  # [max, max_i]
  max_i
end


H, W, D, K = gets.chomp.split(" ").map(&:to_i)
# H W D K
# 200 200 16000 4000

f = Array.new(W) { Array.new(H, nil) }
xl = []
yl = []

D.times do |i|
  x, y = gets.chomp.split(" ").map(&:to_i)
  xl << x
  yl << y
  f[x][y] = i
end

cl = Array.new(D, 0)
c_total = 0
(D-1).times do |i|
  cl[i] = (xl[i] - xl[i+1]).abs + (yl[i] - yl[i+1]).abs
  c_total += cl[i]
end

dl = Array.new(D, 0)
(D-2).times do |i|
  dl[i] = cl[i] + cl[i+1]
end

K.times do
  aa = bb = cc = dd = 0

  target_i = max_index(dl) + 1
  aa = xl[target_i]
  bb = yl[target_i]

  cc = (xl[target_i - 1] + xl[target_i + 1]) / 2
  dd = (xl[target_i - 1] + xl[target_i + 1]) / 2

  target_j = f[cc][dd]
  if target_j
    xl[target_j] = aa
    yl[target_j] = bb

    cl[target_j - 1] = (xl[target_j - 1] - xl[target_j    ]).abs + (yl[target_j - 1] - yl[target_j    ]).abs if target_j - 1 >= 0
    cl[target_j    ] = (xl[target_j    ] - xl[target_j + 1]).abs + (yl[target_j    ] - yl[target_j + 1]).abs if target_j + 1 < D

    dl[target_j - 2] = cl[target_j - 2] + cl[target_j - 1] if target_j - 2 >= 0
    dl[target_j - 1] = cl[target_j - 1] + cl[target_j    ]
    dl[target_j    ] = cl[target_j    ] + cl[target_j + 1] if target_j + 1 < D - 1
  end

  xl[target_i] = cc
  yl[target_i] = dd

  cl[target_i - 1] = (xl[target_i - 1] - xl[target_i    ]).abs + (yl[target_i - 1] - yl[target_i    ]).abs if target_i - 1 >= 0
  cl[target_i    ] = (xl[target_i    ] - xl[target_i + 1]).abs + (yl[target_i    ] - yl[target_i + 1]).abs if target_i + 1 < D

  dl[target_i - 2] = cl[target_i - 2] + cl[target_i - 1] if target_i - 2 >= 0
  dl[target_i - 1] = cl[target_i - 1] + cl[target_i    ]
  dl[target_i    ] = cl[target_i    ] + cl[target_i + 1] if target_i + 1 < D - 1

  puts "#{aa} #{bb} #{cc} #{dd}"
end
