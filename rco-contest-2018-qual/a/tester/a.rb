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

seq_list = []

seq_list << 'U' * t
seq_list << 'D' * t
seq_list << 'L' * t
seq_list << 'R' * t

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

# STDERR.puts "score: #{max_total_score}"
puts max_map_ids.join(' ')
puts max_seq
