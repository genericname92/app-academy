class Tile
  # BOMBED_STATUS (TODO)
  NEIGHBORS = [[0, 1], [0, -1], [1, 0], [-1, 0],
               [1, 1], [1, -1], [-1, 1], [-1, -1]]
  attr_reader :bombed, :revealed
  attr_accessor :flagged

  def initialize(board, bombed, coordinates)
    @board = board
    @bombed = bombed
    @revealed = false
    @flagged = false
    @coordinates = coordinates
  end

  def reveal
    @revealed = true
  end

  def execute_reveal
    self.reveal if neighbor_bomb_count > 0
    self.neighbors.each |coordinates|
      @board.minesweeper_board[coordinates[0]]
  end

  def neighbors
    NEIGHBORS.map do |change|
       [@coordinates[0] + change[0], @coordinates[1] + change[1]]
     end
  end

  def neighbor_bomb_count
    neighbor_bomb_count = 0
     neighbors.each do |tile|
       this_tile = @board.minesweeper_board[tile[0]][tile[1]]
       p this_tile
       neighbor_bomb_count += 1 if this_tile.bombed == 1
    end
    neighbor_bomb_count
  end

  def inspect
    puts "Tile #{@coordinates}: bombed: #{@bombed},
     revealed: #{@revealed}, flagged: #{@flagged}"
  end

  def flag
    if @flagged == false
      @flagged = true
    else
      @flagged = false
    end
  end
end

class Board
  # MAX_MINES = (9 * 9) / 2
  attr_accessor :minesweeper_board, :count

  def initialize(grid_size)
    @minesweeper_board = build_board(grid_size)
  end

  def build_board(grid_size)
    @count = 0
    minesweeper_board = Array.new(grid_size) { Array.new(grid_size) }
    minesweeper_board.each_index do |y|
      minesweeper_board.each_index do |x|
        bombed = rand(2)
        @count += 1 if bombed == 1
        minesweeper_board[y][x] = Tile.new(self, bombed, [x,y])
      end
    end
    minesweeper_board
  end

  def display
    minesweeper_board.each_index do |y|
      minesweeper_board.each_index do |x|
        tile = minesweeper_board[y][x]
        unless tile.flagged
          unless tile.revealed
            print " * "
          else
            print " _ "
          end
        else
          print " F "
        end
      end
      print "\n"
    end
    nil
  end
end

class Game

  def initialize(grid_size = 9)
    puts "Wecome to the minesweeeper game"
    @grid_size = grid_size
    @board = Board.new(grid_size)
    @board.display

  end
  def play
    until over?
      puts "Current board: "
      @board.display
      input = get_input
      process_input(input)
    end
  end

  def get_input
    puts "\"r\" chooses to reveal a tile"
    puts "\"f\" chooses to flag a tile"
    choice = nil
    until valid_input?(choice)
      puts "Enter in the format of: r (y,x)"
      choice = gets.chomp
    end
    match_groups = /([rf]) \((\d+),(\d+)\)/.match(choice)
    return [match_groups[1], match_groups[2], match_groups[3]]
  end

  def process_input(input)
    action, y, x = input
    if action == "r"
      @board.minesweeper_board[y][x].reveal
  end
  def valid_input?(choice)
    match_groups = /([rf]) \((\d+),(\d+)\)/.match(choice)
    unless match_groups
      if match_groups[2] < grid_size && match_groups[3] < grid_size
        return true
      end
    end
    false
  end


end
