class BoardState
  attr_accessor :board
  def initialize(number=8)
    @board = Array.new(number) { Array.new(number) }
    @history = {}
  end

  def display
    @board
  end

  def size_of_board
    @board.size
  end
  def place_queen(coordinates)
    row, col = coordinates
    if @board[row][col].nil?
      @board[row][col] = "Q"
      @history[row] = [[row, col]]
      mark_horizontal(coordinate)
      mark_vertical(coordinate)
      mark_diagonals(coordinate)
      true
    else
      false
    end
  end

  private
    def mark_horizontal(coordinate)
      row = coordinate[0]
      @board[row].each_index do |column|
        mark_spot(row, column, row)
      end

    end

    def mark_vertical(coordinate)
      row, column = coordinate
      @board.each do |current_row|
        mark_spot(current_row, column, row)
      end
    end

    def mark_diagonals(coordinate)
      row, column = coordinate
      #top left
      temp_row = row
      temp_column = column
      while temp_row > 0 && temp_column > 0
        temp_row -= 1
        temp_column -= 1
        mark_spot(temp_row, temp_column, row)
      end
      #top right
      temp_row = row
      temp_column = column
      while temp_row > 0 && temp_column < @board.size
        temp_row -= 1
        temp_column += 1
        mark_spot(temp_row, temp_column, row)
      end
      #down left
      temp_row = row
      temp_column = column
      while temp_row < @board.size && temp_column > 0
        temp_row += 1
        temp_column -= 1
        mark_spot(temp_row, temp_column, row)
      end
      #down right
      temp_row = row
      temp_column = column
      while temp_row < @board.size && temp_column < @board.size
        temp_row += 1
        temp_column += 1
        mark_spot(temp_row, temp_column, row)
      end
    end

    def mark_spot(row, col, queen)
      if @board[row][column].nil?
        @history[queen] << [row, column]
        @board[row][column] = 1
      end
    end

    def delete_history(queen)
      @history[queen].each do |coordinate|
        row, col = coordinate
        @board[row][col] = nil
      end
      @history.delete(queen)
    end

end

class EightQueens

  def initialize
    @board = BoardState.new
    @queen_history = {}
  end

  def solve(row=0)
    if row >= @board.size_of_board
      return @board
    end

    (0..@board.size_of_board).each do |col|
      if @board.place_queen([row, col])
        if solve(row + 1) == true
          return true
        end
        @board.delete_history(row)
      end
    end
    return false
  end

end

game = EightQueens.new
game.solve
