class Player
  attr_reader :color
  def initialize(color)
    @color = color
  end

  def get_sequence
    values = []
    until valid_input?(values)
      puts "Enter a valid sequence in the format of: y, x, y, x"
      puts "Multiple jumps are enforced, put 3+ coordinates for this"
      puts "#{@color}\'s turn"
      user_input = gets.chomp
      values = user_input.chars.select { |s| s =~ /[0-9]/ }
    end
    sequence = []
    values.map(&:to_i).each_slice(2) { |c| sequence << c }
    sequence
  end

  def valid_input?(values)
    values.all? { |x| x.to_i.between?(0, 7) } && values.length.even? && values.length > 3
  end
end
