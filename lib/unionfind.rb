# Union-Find tree
class UF
  attr_accessor :elements
  def initialize(elements)
    @elements = elements.dup
    @count = @elements.count
    @parents = {}
  end

  def union!(x, y)
    x = find_root(x)
    y = find_root(y)
    return if x == y
    @parents[x] = y
    return
  end

  def connected?(x, y)
    find_root(x) == find_root(y)
  end

  def find_root(x)
    y = x
    while (parent = @parents[y]) != y
      y = parent
    end
    while (parent = @parents[x]) != x
      @parents[x] = y
      x = parent
    end
    y
  end
end
