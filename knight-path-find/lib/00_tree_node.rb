require 'byebug'

class PolyTreeNode
  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  attr_reader :parent, :children, :value

  def parent=(parent_node)

    @parent.children.delete(self) unless @parent.nil?
    @parent = parent_node
    @parent.children << self unless @parent.nil? || @parent.children.include?(self)

    @parent
  end

  def add_child(child_node)
    unless @children.include?(child_node)
      @children << child_node
      child_node.parent = self
    end
  end

  def remove_child(child_node)
    raise unless @children.include?(child_node)
    child_node.parent = nil
    @children.delete(child_node)
  end

  def dfs(target_value)
    @children.each do |child|
      result = child.dfs(target_value)
      return result unless result.nil?
    end
    return self if @value == target_value
    nil
  end

  def bfs(target_value)
    queue = [self]
    until queue.empty?
      node = queue.shift
      return node if node.value == target_value
      queue += node.children
    end
    nil
  end

end
