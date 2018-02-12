# require 'pp'

class PQueue
  def initialize(elements=nil, &block)
    @que = []
    @cmp = block || lambda{ |a,b| a <=> b }
    replace(elements) if elements
  end

protected
  attr_reader :que #:nodoc:

public
  attr_reader :cmp

  def size
    @que.size
  end
  alias length size

  def push(v)
    @que << v
    reheap(@que.size-1)
    self
  end
  alias enq push
  alias :<< :push

  def pop
    return nil if empty?
    @que.pop
  end
  alias deq pop

  def shift
    return nil if empty?
    @que.shift
  end

  def top
    return nil if empty?
    return @que.last
  end
  alias peek top

  def bottom
    return nil if empty?
    return @que.first
  end

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

  def empty?
    @que.empty?
  end

  def clear
    @que.clear
    self
  end

  def replace(elements)
    if elements.kind_of?(PQueue)
      initialize_copy(elements)
    else
      @que.replace(elements.to_a)
      sort!
    end
    self
  end

  def to_a
    @que.dup
  end

  def include?(element)
    @que.include?(element)
  end

  def swap(v)
    r = pop
    push(v)
    r
  end

  def each_pop
    until empty?
      yield pop
    end
    nil
  end

  def inspect
    "<#{self.class}: size=#{size}, top=#{top || "nil"}>"
  end

  def ==(other)
    size == other.size && to_a == other.to_a
  end

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

n, k, h, w, t = gets.chomp.split(" ").map(&:to_i)
N = 100
K = 8
H = 50
W = 50
T = 2500

class Field < Struct.new(:id, :rows, :x, :y, :alive, :score)
  def [](yy)
    rows[yy]
  end

  def dup
    new_rows = []
    rows.each do |row|
      new_rows << row.dup
    end
    Field.new(id, new_rows, x, y, alive, score)
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
      list << gen_next_state(ch) if ch != seq[-1]
    end
    list
  end

  def gen_next_state(ch)
    state = dup
    state.move!(ch)
    state
  end

  def move!(ch)
    self.len += 1
    self.seq << ch
    fields.each { |f| f.move!(ch) }
    self.score = fields.map(&:score).reduce(&:+)
  end

  def prune?
    fields.any? { |f| !f.alive }
  end

  def dup
    new_fields = []
    fields.each do |field|
      new_fields << field.dup
    end
    State.new(len, seq.dup, score, new_fields)
  end

  def <=>(other)
    return 1 if score > other.score
    return -1 if score < other.score
    return 1 if len > other.len
    return -1 if len < other.len
    0
  end
end


def choose_fields(fields)
  fields.sample(8)
end

def solve(fields)
  start_time = Time.new
  q = PQueue.new

  state = State.new(0, '', 0, fields)
  q << state

  max_score = 0
  max_seq = ''

  queue_size_max = 10 ** 3

  while(!q.empty?) do
    state = q.pop
    if state.score > max_score
      max_score = state.score
      max_seq = state.seq
    end

    current_time = Time.now
    elapsed = current_time - start_time
    # STDERR.puts "q.size:#{q.size} seq:#{state.len} score:#{state.score} max:#{max_score} elapsed:#{elapsed}"
    break if elapsed > 3.9

    next if state.prune?
    # next if state.score < max_score * 8 / 10

    state.next_states.each do |next_state|
      q << next_state
    end

    if q.size > queue_size_max
      (q.size - queue_size_max).times { q.shift }
    end
  end

  max_seq
end

fields = []

n.times do |i|
  rows = []
  init_x = init_y = nil
  h.times do |y|
    row = gets.chomp
    rows << row
    x = row.index('@')
    if x
      init_x = x
      init_y = y
    end
  end
  fields << Field.new(i, rows, init_x, init_y, true, 0)
end



target_fields = choose_fields(fields)
seq = solve(target_fields)

puts target_fields.map(&:id).join(' ')
puts seq
