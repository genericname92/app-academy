require_relative '00_tree_node.rb'

class KnightPathFinder
  ALL_MOVES = [
    [1,2], [-1,2], [1,-2], [-1,-2],
    [2,1], [-2,-1], [-2,1], [2,-1]
  ]

  def initialize(start)
    @start = start
    @visited_positions = [start]
    build_move_tree
  end

  def valid_moves(pos)
    x, y = pos
    valid_moves = []
    ALL_MOVES.each do |move|
        next_position = [move[0] + x, move[1] + y]
        #doesn't go off grid
        if next_position[0] > 7 || next_position[0] < 0
          next
        elsif next_position[1] > 7 || next_position[1] < 0
          next
        else
          valid_moves << next_position
        end
      end

    valid_moves
  end

  def new_move_positions(pos)
    new_positions = valid_moves(pos).reject { |x| @visited_positions.include?(x) }
    new_positions.each { |x| @visited_positions << x }

    new_positions
  end

  def build_move_tree
    @root_node = PolyTreeNode.new(@start)
    queue = [@root_node]
    position = @start
    until queue.empty?
      current_node = queue.shift
      position = current_node.value
      new_move_positions(position).each do |pos|
        new_node = PolyTreeNode.new(pos)
        current_node.add_child(new_node)
        queue << new_node
      end
    end
  end

  def find_path(end_pos)
    end_node = @root_node.bfs(end_pos)
    end_node.trace_path_back
  end

  def root_node
    @root_node
  end
end
