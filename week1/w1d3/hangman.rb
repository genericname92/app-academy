module HangmanGame
  class Hangman

    def initialize(player1, player2)
      @player1, @player2 = player1, player2
      @guesses = 0
    end

    def display
      @player2.handle_guess_response(@display_word.join(''))
      puts @display_word.join(' ')
    end

    def play
      set_up_game
      until @display_word.join("") == @secret_word
        guess = @player2.guess
        @guesses += 1
        update_display(guess)
        display
      end

      puts "You won in #{@guesses} guesses"

    end

    def update_display(guess)
      @display_word.each_index do |index|
        @display_word[index] = guess if @secret_word[index] == guess
      end
    end

    def set_up_game
      @secret_word = @player1.pick_secret_word
      @display_word = ["_"] * @secret_word.length
      @player2.receive_secret_length(@secret_word.length)

      display
    end


  end

  class HumanPlayer

    def initialize
      @valid_words = File.readlines("dictionary.txt").map(&:chomp)
      @guessed_letters = []
      @user_input = ""
    end

    def pick_secret_word
      until @valid_words.include?(@user_input.downcase)
        puts "Pick a secret word"
        @user_input = String(gets.chomp)
      end

      @user_input
    end

    def receive_secret_length(word_length)
      @word_length = word_length
    end

    def guess
      puts "Enter a letter"
      @user_input = String(gets.chomp.downcase)
      until valid_guess?(@user_input)
        @user_input = String(gets.chomp.downcase)
        puts "Word length is: #{@word_length}" if @user_input.include?("length")
      end
      @guessed_letters << @user_input

      @user_input
    end

    def valid_guess?(guess)
      !@guessed_letters.include?(guess) && guess =~ /^[a-z]$/
    end

    def handle_guess_response(string)
    end

  end


  class ComputerPlayer

    def initialize
      @valid_words = File.readlines("dictionary.txt").map(&:chomp)
      @guessed_letters = []
      @greatest_letter_matches = 0
    end

    def pick_secret_word
      @valid_words.sample
    end

    def receive_secret_length(word_length)
      @word_length = word_length
      # Reduce word list by length
      @valid_words = @valid_words.select { |word| word.length == @word_length }
    end

    def guess
      update_valid_words
      until valid_guess?(@computer_input)
        @computer_input = @valid_words.sample.chars.sample
      end
      @guessed_letters << @computer_input

      @computer_input
    end

    def update_valid_words
      update_by_conflict
      update_by_letter_matches
    end

    def update_by_conflict
      @valid_words = @valid_words.select do |word|
        no_conflict = true
        word.chars.each_index do |index|
          next if @current_display[index] == "_"
          no_conflict = false if @current_display[index] != word[index]
        end
        return word if no_conflict
      end
    end

    def update_by_letter_matches
      @valid_words = @valid_words.select do |word|
        letter_matches = 0
        word.chars.each_index do |index|
          next if @current_display[index] == "_"
          letter_matches += 1 if @current_display[index] == word[index]
        end

        if @greatest_letter_matches <= letter_matches
          @greatest_letter_matches = letter_matches
          return word
        end

      end
    end

    def valid_guess?(guess)
      !@guessed_letters.include?(guess) && guess =~ /^[a-z]$/
    end

    def handle_guess_response(string)
      @current_display = string
    end

  end
end
if __FILE__ == $PROGRAM_NAME
  p1 = HangmanGame::HumanPlayer.new
  p2 = HangmanGame::ComputerPlayer.new
  p3 = HangmanGame::ComputerPlayer.new
  game = HangmanGame::Hangman.new(p2, p3)
  game.play
end
