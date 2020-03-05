#define Leaf class with value and two children
class Leaf
  attr_reader :value
  attr_accessor :left, :right

  def initialize(value=nil)
    @value = value
    left = nil;
    right = nil;
    return self
  end
end

#Define Tree that is connection of Leaf
class Tree
  #root_leaf is the first leaf of a tree
  attr_accessor :root_leaf

  def initialize(root_value=nil)
    @root_leaf = Leaf.new(root_value)
    return self
  end

  #method that insert new value into the tree
  def insert(leaf, value)
    if @value == nil
      @value = value
      return self
    elsif @value == value
      return leaf
    elsif value < @value
      insert(leaf.left, value)
    elsif value > @value
      insert(leaf.right, value)
    end
  end
end

#Function that transfer a hash to a Tree
def hashToTree(hsh, t)
  hsh.each_value {|v| t.insert(t, v)}
  return t
end

#Some test cases that (raises error)
h = {1=>1, 2=>2, 3=>3, 6=>6, 5=>5}
t = Tree.new()
puts "#{hashToTree(h, t)}"





