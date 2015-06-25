class Code
  TYPES_OF_COLORS = ["r", "g", "b", "y", "o", "p"]

  def initialize(code)
    @code = code
  end

  def exact_matches(other_code)
    matches = 0
    @code.each_with_index do |color, position|
      matches += 1 if other_code[position] == color
    end
    matches
  end

#probably should be refactored, too verbose
  def near_matches(other_code)
    matches = 0
    TYPES_OF_COLORS.each do |color|
      if @code.include?(color) && other_code.include?(color)
        if @code.count(color) > other_code.count(color)
          matches += other_code.count(color)
        else
          matches += @code.count(color)
        end
      end
    end
    matches
  end

  def self.generate_code
    code = (0..3).collect { |x| TYPES_OF_COLORS[rand(6)]}
    return Code.new(code)
  end

end

class Game
  def initialize
    @correct_result = Code.generate_code
    @guesses = 0
  end

  def prompt
    puts "Enter in a combination of r, g, b, y, o, p"
    valid_input = false
    until valid_input
      user_input = String(gets.downcase.chomp)
      if valid?(user_input)
        valid_input = user_input
      else
        puts "That's not a valid combo"
      end
    end
    @guesses += 1
    user_input
  end

  def valid?(user_input)
    user_input =~ /^[rgbyop]{4}$/
  end
#needs to be implemented
  def run
    user_input = prompt
    until @guesses == 10 || @correct_result.exact_matches(user_input) == 4
      user_near_matches = @correct_result.near_matches(user_input)
      user_exact_matches = @correct_result.exact_matches(user_input)
      puts "#{user_exact_matches} exact matches were made"
      puts "#{user_near_matches} near matches were made"
      user_input = prompt
      puts "You are on guess #{@guesses}"
    end

    puts @guesses < 10 ? "you won in #{@guesses} guesses" : "you lose"

  end


end

game = Game.new
game.run
