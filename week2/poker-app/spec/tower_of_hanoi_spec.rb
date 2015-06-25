require 'towers_of_hanoi'

describe Game do
  subject { Game.new }
  # let(:game) { Game.new() }

  it "It initializes properly" do

    expect(subject.pegs).to eq([[3, 2, 1], [], []])
  end

  describe "Game#move" do

    it "Moves discs to another peg" do
      subject.move(0, 1)

      expect(subject.pegs).to eq([[3, 2], [1], []])
    end


    it "Raises an error if you try to perform an illegal move" do
      subject.move(0, 1)
      expect { subject.move(0, 1) }.to raise_error(IllegalMoveError)
    end

    it "Raises an error if you try move from an empty peg" do
      expect { subject.move(1, 2) }.to raise_error(IllegalMoveError)
    end

  end

  describe "Game#won?" do
    let(:won_game1) { [[], [], [3, 2, 1]] }
    let(:won_game2) { [[], [3, 2, 1], []] }
    let(:continued_game) { [[3, 2], [], [1]] }
    it "returns true if won" do
      subject.pegs = won_game1
      expect(subject.won?).to eq(true)
      subject.pegs = won_game2
      expect(subject.won?).to eq(true)
    end
    it "return false if not won" do
      subject.pegs = continued_game
      expect(subject.won?).to eq(false)
    end
  end
end
