class IllegalMoveError < StandardError
end

class Game
  attr_accessor :pegs

  def initialize
    @pegs = [[3, 2, 1], [], []]
  end

  def move(start, finish)
    if @pegs[start].empty?
      raise IllegalMoveError
    elsif @pegs[finish].empty?
      @pegs[finish] << @pegs[start].pop
    elsif @pegs[finish].last < @pegs[start].last
      raise IllegalMoveError
    else
      @pegs[finish] << @pegs[start].pop
    end
  end

  def won?
    return true if @pegs[1] == [3, 2, 1] || @pegs[2] == [3, 2, 1]
    false
  end


end
