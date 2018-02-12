require 'pp'
n, k, h, w, t = gets.chomp.split(" ").map(&:to_i)

fields = Array.new(n) { [] }
origin_list = []

n.times do |i|
  h.times do |y|
    row = gets.chomp
    fields[i] << row
    x = row.index('@')
    if x
      origin_list << [x, y]
    end
  end
end

# pp fields
def dup_field(original)
  field = []
  original.each do |row|
    field << row.dup
  end
  field
end

def judge(field, x, y, seq)
  field = dup_field(field)

  score = 0
  len = seq.size
  len.times do |i|
    c = seq[i]
    case c
    when 'U'
      y -= 1 unless field[y-1][x] == '#'
    when 'D'
      y += 1 unless field[y+1][x] == '#'
    when 'L'
      x -= 1 unless field[y][x-1] == '#'
    when 'R'
      x += 1 unless field[y][x+1] == '#'
    end

    case field[y][x]
    when 'o'
      score += 1
      field[y][x] = ' '
    when 'x'
      return score
    end
  end

  score
end

def judge_all(fields, origin_list, k, seq)
  score_list = []
  fields.each_with_index do |field, i|
    x, y = origin_list[i]
    score_list << [judge(field, x, y, seq), i]
  end
  score_list.sort_by! { |score, map_id| -score }
  score_list = score_list[0..k-1]
  total_score = score_list.map { |score, map_id| score }.reduce(&:+)
  map_ids = score_list.map { |score, map_id| map_id }
  # STDERR.puts score_list
  [total_score, map_ids]
end


def guruguru_comb(r, rep)
  seq = ''

  rep.times do
    (1..r).each do |i|
      if i.even?
        seq << 'R' * i
        seq << 'U' * i
      else
        seq << 'L' * i
        seq << 'D' * i
      end
    end

    (1..r).each do |i|
      if i.even?
        seq << 'L' * i
        seq << 'U' * i
      else
        seq << 'R' * i
        seq << 'D' * i
      end
    end
  end

  seq[0..2499]
end

def guruguru_comb2(r, rep)
  seq = ''

  a = 1
  b = r
  rep.times do
    (a..b).each do |i|
      if i.even?
        seq << 'R' * i
        seq << 'U' * i
      else
        seq << 'L' * i
        seq << 'D' * i
      end
    end

    (a..b).each do |i|
      if i.even?
        seq << 'L' * i
        seq << 'U' * i
      else
        seq << 'R' * i
        seq << 'D' * i
      end
    end
    a = b
    b = a + r
  end

  seq[0..2499]
end

def snake(len, rep)
  seq = ''

  rep.times do |i|
    seq << 'U' * len
    seq << 'R'
    seq << 'D' * len
    seq << 'R'
  end

  seq[0..2499]
end

seq_list = []

seq_list << guruguru_comb(15, 6)
seq_list << guruguru_comb(20, 6)
seq_list << guruguru_comb(25, 6)
seq_list << guruguru_comb(30, 6)

seq_list << guruguru_comb2(3, 20)
seq_list << guruguru_comb2(5, 20)
seq_list << guruguru_comb2(7, 20)
seq_list << guruguru_comb2(10, 20)

seq_list << snake(25, 30)
seq_list << snake(30, 30)
seq_list << snake(35, 30)

# seq_list << guruguru_comb2(5, 20)[0..999] + snake(30, 30)[0..999] + guruguru_comb2(5, 20)[0..499]
# seq_list << guruguru_comb2(5, 20)[0..499] + snake(30, 30)[0..499] + guruguru_comb2(5, 20)[0..499] + snake(30, 30)[0..499] + guruguru_comb2(5, 20)[0..499]
seq_list << ((guruguru_comb2(5, 20)[0..399] + snake(30, 30)[0..99]) * 5)[0..2499]
seq_list << ((guruguru_comb2(5, 20)[0..499] + snake(30, 30)[0..99]) * 5)[0..2499]
seq_list << ((guruguru_comb2(5, 20)[0..599] + snake(30, 30)[0..99]) * 5)[0..2499]

# seq_list << snake(30, 30)[0..999] + guruguru_comb2(5, 20)[0..999] + snake(30, 30)[0..499]
# seq_list << snake(30, 30)[0..499] + guruguru_comb2(5, 20)[0..499] + snake(30, 30)[0..499] + guruguru_comb2(5, 20)[0..499] + snake(30, 30)[0..499]

max_total_score = 0
max_map_ids = []
max_seq = ''

seq_list.each do |seq|
  total_score, map_ids = judge_all(fields, origin_list, k, seq)

  if total_score > max_total_score
    max_total_score = total_score
    max_map_ids = map_ids
    max_seq = seq
  end
end

STDERR.puts "score: #{max_total_score}"
puts max_map_ids.join(' ')
puts max_seq
