require 'colorize'
class Board
  attr_accessor :grid
  def initialize(grid = nil)
    if grid
      @grid = grid
    else
      @grid = Array.new(8) { Array.new(8) }
      set_up_pieces(0, 2, :black)
      set_up_pieces(5, 7, :white)
    end
  end

  def [](pos)
    y, x = pos
    @grid[y][x]
  end

  def []=(pos, piece)
    y, x = pos
    @grid[y][x] = piece
  end


  def set_up_pieces(row_start, row_end, color)
    (row_start..row_end).each do |y|
      if y.even?
        (0..6).step(2).each { |x| @grid[y][x] = Piece.new([y,x], color, self) }
      else
        (1..7).step(2).each { |x| @grid[y][x] = Piece.new([y,x], color, self) }
      end
    end
  end

  def display
    system "clear"
    puts "\n"
    puts "    0  1  2  3  4  5  6  7 ".magenta
    @grid.each_index do |y|
      print " #{y} ".magenta
      @grid[y].each_index do |x|
        background_color = (y + x).even? ? :red : :black
        if @grid[y][x].nil?
          print "   ".colorize(:background => background_color)
        elsif @grid[y][x].color == :white
          print " W ".colorize(:color => :white, :background => background_color)
        elsif @grid[y][x].color == :black
          print " B ".colorize(:color => :white, :background => background_color)
        else
          print "wtf"
        end
      end
      print "\n"
    end
  end

  def dup_board
    duped_board = Board.new
    duped_board.grid.each_index do |y|
      duped_board.grid[y].each_index do |x|
        if @grid[y][x].nil?
          duped_board.grid[y][x] = nil
        else
          duped_board.grid[y][x] = @grid[y][x].dup_piece(duped_board)
        end
      end
    end
    duped_board
  end

  def has_valid_moves?(color)
    color_pieces(color).any? { |piece| piece.can_move? }
  end
  def all_pieces
    @grid.flatten.compact
  end
  def color_pieces(color)
    color_pieces = all_pieces.select { |piece| piece.color == color }
  end
  def find_piece(color, coordinates)
    list = color_pieces(color)
    list.find { |piece| piece.position == coordinates }
  end

  def can_jump?(color)
    pieces = color_pieces(color)
    pieces.any? { |piece| piece.jump_available? }
  end

  def in_bounds?(coordinate)
    coordinate.all? { |x| x.between?(0, 7) }
  end
end
