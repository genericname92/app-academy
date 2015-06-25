require_relative 'piece'
require_relative 'board'
require_relative 'player'

class Game
  def initialize
    @board = Board.new
    @player1 = Player.new(:white)
    @player2 = Player.new(:black)
    @turn = @player1
  end

  def play
    while @board.has_valid_moves?(@turn.color)
      begin
        @board.display
        sequence = @turn.get_sequence
        piece = @board.find_piece(@turn.color, sequence.shift)
        raise InvalidMoveError if piece.nil?
        piece.perform_moves(sequence)
      rescue InvalidMoveError
        puts "Invalid input detected"
        sleep 0.5
        retry
      rescue MustJumpError
        puts "You must jump!"
        sleep 0.5
        retry
      end
      switch_turn
    end
    switch_turn
    puts "#{@turn} has won!"
  end

  def switch_turn
    @turn = (@turn == @player1 ? @player2 : @player1 )
  end

end

g = Game.new
g.play
