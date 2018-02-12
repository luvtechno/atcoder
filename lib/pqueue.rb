# https://github.com/rubyworks/pqueue/blob/master/lib/pqueue.rb
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
