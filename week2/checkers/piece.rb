
class InvalidMoveError < RuntimeError
end

class Piece
  WHITE_MOVES = [[-1, -1], [-1, 1]]
  BLACK_MOVES = [[1, 1], [1, -1]]
  KING = WHITE_MOVES + BLACK_MOVES

  attr_reader :position, :color

  def initialize(position, color, board, king = false)
    @position = position
    @color = color
    @board = board
    @king = king
  end

  def can_move?
    return true if jump_available?
    list = find_list
    duped_board = @board.dup_board
    list.each do |coor|
      test_pos = [@position[0] + coor[0], @position[1] + coor[1]]
      next unless @board.in_bounds?(test_pos)
      if duped_board[@position].perform_slide(test_pos)
        return true
      end
    end
    false
  end

  def perform_slide(coordinates)
    list = find_list
    list.each do |move|
      new_coordinates = [@position[0] + move[0], @position[1] + move[1]]
      next unless @board.in_bounds?(new_coordinates)
      if new_coordinates == coordinates && @board[coordinates].nil?
        @board[new_coordinates] = self
        @board[@position] = nil
        @position = new_coordinates
        maybe_promote
        return true
      end
    end
    false
  end

  def perform_jump(coordinates)
    list = find_list
    list.each do |move|
      capture = [@position[0] + move[0], @position[1] + move[1]]
      end_square = [capture[0] + move[0], capture[1] + move[1]]
      next unless @board.in_bounds?(capture + end_square)
      if end_square == coordinates && @board[end_square].nil?
        if !@board[capture].nil? && @board[capture].color != @color
          @board[capture] = nil
          @board[end_square] = self
          @board[@position] = nil
          @position = end_square
          maybe_promote
          return true
        end
      end
    end
    false
  end

  def perform_moves(move_sequence)
    if valid_move_seq?(move_sequence)
      perform_moves!(move_sequence)
    else
      raise InvalidMoveError
    end
  end


  def perform_moves!(move_sequence)
    can_slide = false
    can_slide = true unless @board.can_jump?(@color)
    if move_sequence.length == 1
      if can_slide
        unless perform_slide(move_sequence.first)
          perform_jump(move_sequence.first)
          raise InvalidMoveError if jump_available?
        end
      else
        jump = perform_jump(move_sequence.first)
        raise InvalidMoveError if jump_available? || jump == false
      end
    else
      move_sequence.each do |move|
        raise InvalidMoveError unless perform_jump(move)
      end
      raise InvalidMoveError if jump_available?
    end

  end

  def jump_available?
    duped_board = @board.dup_board
    list = find_list
    list.each do |coor|
      test_pos = [@position[0] + 2 * coor[0], @position[1] + 2 * coor[1]]
      next unless @board.in_bounds?(test_pos)
      if duped_board[@position].perform_jump(test_pos)
        return true
      end
    end
    false
  end

  def dup_piece(duped_board)
    Piece.new(@position, @color, duped_board, @king)
  end

  def valid_move_seq?(move_list)
    duped_board = @board.dup_board
    begin
      duped_board[@position].perform_moves!(move_list)
    rescue InvalidMoveError
      return false
    else
      return true
    end
  end
private

def maybe_promote
  if @color == :white && @position[0] == 0
    @king = true
  elsif @color == :black && @position[0] == 7
    @king = true
  end
  @king
end

def find_list
  if @king
    KING
  else
    @color == :white ? WHITE_MOVES : BLACK_MOVES
  end
end

end #end class
