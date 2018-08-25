require 'byebug'
class PolyTreeNode
  def initialize(value)
    @parent = nil
    @children = []
    @value = value
  end
  
  def parent
    @parent
  end
  
  def children
    @children
  end
  
  def value
    @value
  end
  
  def parent=(node)
    old_parent = self.parent
    node.nil? ? @parent = nil : @parent = node
    if !node.nil?
      node.children << self if !node.children.include?(self)
    end
    if @parent.nil? || (!old_parent.nil? && old_parent != @parent)
      old_parent.children.delete(self)
    end
  end
  
  # def children=(child)
  #   @children << child if !@children.include?(child)
  # end
  
  def add_child(child_node)
    child_node.parent=(self)
  end
  
  def remove_child(child_node)
    raise "This node is not a child" if child_node.nil?
    child_node.parent=(nil)
  end
  
  def dfs(target_value)
    p self
    p self.value
    return self if self.value == target_value
    
    @children.each_with_index do |child, i|
      i == 2 ? next : result = child.dfs(target_value)
      return result if result == target_value
    end
    
  end
  
  def inspect
    puts "Node = #{@value}; Parent: #{@parent ? @parent.value : ""}; Children: #{@children.map { |x| x.value }}"
  end
end