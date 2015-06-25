require 'byebug'

class PolyTreeNode
  attr_accessor :children

  def initialize(value)
    @parent = nil
    @children = []
    @value = value
  end

  def add_child(child)
    child.parent=(self)
  end

  def bfs(target)
    queue = [self]
    while !queue.empty?
      current_node = queue.shift
      current_value = current_node.value
      if current_value == target
        return current_node
      else
        current_node.children.each do |child|
          queue.push(child)
        end
      end
    end
  end

  def dfs(target)
    if @value == target
      return self
    elsif @children.empty?
      return nil
    else
      @children.each do |child|
        next_child = child.dfs(target)
        if next_child.nil?
          next
        else
          return next_child
        end
      end
      nil
    end
  end

  def parent
    @parent
  end

  def parent=(argument = nil)
    @parent.children.delete(self) unless @parent.nil?
    @parent = argument
    @parent.children << self unless argument.nil?
  end

  def remove_child(child)
    raise "Not a child" if  !children.include?(child)
    child.parent=(nil)

  end

  def trace_path_back
    return [@value] if @parent.nil?
    next_value = @parent.trace_path_back
    next_value << @value
    next_value
  end

  def value
    @value
  end


end
