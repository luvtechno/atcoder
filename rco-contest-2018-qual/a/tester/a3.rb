# require 'pp'
start_time = Time.new
time_limit = (ARGV[0] || 3.90).to_f
GC.disable

class PQueue
  def initialize(elements=nil, &block)
    @que = []; @cmp = block || lambda{ |a,b| a <=> b }
    replace(elements) if elements
  end
protected
  attr_reader :que
public
  attr_reader :cmp
  def size; @que.size; end
  alias length size
  def push(v); @que << v; reheap(@que.size-1); self; end
  alias enq push
  alias :<< :push
  def pop; return nil if empty?; @que.pop; end
  alias deq pop
  def shift; return nil if empty?; @que.shift; end
  def top; return nil if empty?; return @que.last; end
  alias peek top
  def bottom; return nil if empty?; return @que.first; end
  def concat(elements)
    if empty?
      if elements.kind_of?(PQueue)
        initialize_copy(elements)
      else
        replace(elements)
      end
    else
      if elements.kind_of?(PQueue)
        @que.concat(elements.que)
        sort!
      else
        @que.concat(elements.to_a)
        sort!
      end
    end
    return self
  end
  alias :merge! :concat
  def take(n=@size)
    a = []
    n.times{a.push(pop)}
    a
  end
  def empty?; @que.empty?; end
  def clear; @que.clear; self; end
  def replace(elements)
    if elements.kind_of?(PQueue)
      initialize_copy(elements)
    else
      @que.replace(elements.to_a)
      sort!
    end
    self
  end
  def to_a; @que.dup; end
  def include?(element); @que.include?(element); end
  def swap(v); r = pop; push(v); r; end
  def each_pop
    until empty?
      yield pop
    end
    nil
  end
  def inspect; "<#{self.class}: size=#{size}, top=#{top || "nil"}>"; end
  def ==(other); size == other.size && to_a == other.to_a; end
private
  def initialize_copy(other)
    @cmp  = other.cmp
    @que  = other.que.dup
    sort!
  end
  def reheap(k)
    return self if size <= 1
    que = @que.dup
    v = que.delete_at(k)
    i = binary_index(que, v)
    que.insert(i, v)
    @que = que
    return self
  end
  def sort!
    @que.sort! do |a,b|
      case @cmp.call(a,b)
      when  0, nil   then  0
      when  1, true  then  1
      when -1, false then -1
      else
        warn "bad comparison procedure in #{self.inspect}"
        0
      end
    end
    self
  end
  alias heapify sort!
  def binary_index(que, target)
    upper = que.size - 1
    lower = 0
    while(upper >= lower) do
      idx  = lower + (upper - lower) / 2
      comp = @cmp.call(target, que[idx])
      case comp
      when 0, nil
        return idx
      when 1, true
        lower = idx + 1
      when -1, false
        upper = idx - 1
      else
      end
    end
    lower
  end
end

n, k, h, w, t = STDIN.gets.chomp.split(" ").map(&:to_i)
N = 100
K = 8
H = 50
W = 50
T = 2500

class Field < Struct.new(:id, :rows, :x, :y, :alive, :score, :c_c, :c_w, :c_t)
  def [](yy)
    rows[yy]
  end

  def dup
    new_rows = []
    rows.each do |row|
      new_rows << row.dup
    end
    Field.new(id, new_rows, x, y, alive, score, c_c, c_w, c_t)
  end

  def move!(ch)
    return unless alive

    case ch
    when 'U'
      self.y -= 1 unless rows[y-1][x] == '#'
    when 'D'
      self.y += 1 unless rows[y+1][x] == '#'
    when 'L'
      self.x -= 1 unless rows[y][x-1] == '#'
    when 'R'
      self.x += 1 unless rows[y][x+1] == '#'
    end

    case rows[y][x]
    when 'o'
      self.score += 1
      rows[y][x] = ' '
    when 'x'
      self.alive = false
    end
  end

  def move(ch)
    new_field = dup
    new_field.move!(ch)
    new_field
  end
end

class State < Struct.new(:len, :seq, :score, :fields)
  CH = ['U', 'D', 'L', 'R'].freeze
  def next_states
    list = []
    CH.each do |ch|
      CH.each do |ch2|
        # CH.each do |ch3|
          list << gen_next_state(ch, ch2)
        # end
      end
    end
    # list << gen_next_state('U') if seq[-1] != 'D'
    # list << gen_next_state('D') if seq[-1] != 'U'
    # list << gen_next_state('L') if seq[-1] != 'R'
    # list << gen_next_state('R') if seq[-1] != 'L'
    list
  end

  def gen_next_state(*ch_list)
    state = dup
    ch_list.each do |ch|
      state.move!(ch)
    end
    state
  end

  def move!(ch)
    self.len += 1
    self.seq << ch
    fields.each { |f| f.move!(ch) }
    self.score = fields.map(&:score).reduce(&:+)
  end

  def prune?
    len >= 2500 || fields.any? { |f| !f.alive }
  end

  def dup
    new_fields = []
    fields.each do |field|
      new_fields << field.dup
    end
    State.new(len, seq.dup, score, new_fields)
  end

  def value
    score
  end

  def <=>(other)
    value <=> other.value
  end
end


def choose_fields(fields)
  [
    # fields.sample(8),
    # fields.sample(8),
    fields[0..7],
    # fields.sort_by { |f| f.c_c * 2 - f.c_t }[0..7],
    # fields.sort_by { |f| - f.c_c }[0..7],
  ]
end

def solve(field_sets, start_time, time_limit)
  q = PQueue.new

  field_sets.each do |fields|
    state = State.new(0, '', 0, fields)
    q << state
  end

  max_score = 0
  max_state = nil

  queue_size_max = 30

  len = 0
  elapsed = 0
  loop do
    STDERR.puts "q:#{q.size} len:#{len} max:#{max_score} elapsed:#{elapsed}"
    break if (elapsed = Time.now - start_time) > time_limit

    next_q = PQueue.new
    while(!q.empty?) do
      state = q.pop
      if state.score > max_score
        max_score = state.score
        max_state = state
      end

      break if (elapsed = Time.now - start_time) > time_limit

      next if state.prune?

      state.next_states.each do |next_state|
        next_q << next_state
      end

      if next_q.size > queue_size_max
        (next_q.size - queue_size_max).times { next_q.shift }
      end
    end

    q = next_q

    len += 1
    break if len >= 2500
  end

  max_state
end

fields = []

n.times do |i|
  rows = []
  init_x = init_y = nil
  c_c = c_w = c_t = 0
  h.times do |y|
    row = STDIN.gets.chomp
    rows << row
    row.chars.each_with_index do |ch, x|
      case ch
      when '@'
        init_x = x
        init_y = y
      when 'o'
        c_c += 1
      when 'x'
        c_t += 1
      when '#'
        c_w += 1
      end
    end
  end
  fields << Field.new(i, rows, init_x, init_y, true, 0, c_c, c_w, c_t)
end



target_field_sets = choose_fields(fields)
state = solve(target_field_sets, start_time, time_limit)

puts state.fields.map(&:id).join(' ')
puts state.seq[0..2499]
