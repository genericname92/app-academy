require 'rspec'
require 'hand'

describe Hand do

  let(:straightflush) do
     array = []
     Card.values[0..4].each {|v| array << Card.new(:clubs, v) }
     array
   end

   let(:nada) do
     array = [Card.new(:clubs, :deuce),
              Card.new(:hearts, :five),
              Card.new(:spades, :seven),
              Card.new(:diamonds, :nine),
              Card.new(:clubs, :jack)
              ]
              array
            end

  let(:randomhand) do
    array = []
    until array.length == 5 do
      new_card = Card.new(Card.suits.sample, Card.values.sample)
      unless array.any? { |card| new_card.suit == card.suit && new_card.value == card.value}
        array << new_card
      end
    end
    array
  end

  let(:onepair) do
    array = [Card.new(:clubs, :ace),
             Card.new(:diamonds, :ace),
             Card.new(:diamonds, :deuce),
             Card.new(:spades, :king),
             Card.new(:spades, :jack)]
           end

  let(:trips) do
     array = [Card.new(:clubs, :king),
              Card.new(:diamonds, :ace),
              Card.new(:diamonds, :king),
              Card.new(:spades, :king),
              Card.new(:spades, :jack)]
            end

  let(:fullhouse) do
     array = [Card.new(:clubs, :king),
              Card.new(:diamonds, :ace),
              Card.new(:diamonds, :king),
              Card.new(:spades, :king),
              Card.new(:spades, :ace)]
            end

  let(:quads) do
    array = [Card.new(:clubs, :king),
             Card.new(:diamonds, :ace),
             Card.new(:diamonds, :king),
             Card.new(:spades, :king),
             Card.new(:hearts, :king)]
           end

  let(:twopair) do
   array = [Card.new(:clubs, :ace),
            Card.new(:diamonds, :ace),
            Card.new(:diamonds, :deuce),
            Card.new(:spades, :deuce),
            Card.new(:spades, :jack)]
          end

  describe "#is_straight?" do
    subject { Hand.new(straightflush) }

    it "returns true if is a straight" do
      expect(subject.is_straight?).to eq(true)
    end

    it "return false for onepair hand" do
      hand = Hand.new(onepair)
      expect(hand.is_straight?).to eq(false)
    end
  end

  describe "#is_flush?" do
    subject { Hand.new(straightflush) }

    it "returns true if is a flush" do
      expect(subject.is_flush?).to eq(true)
    end

    it "returns false for one pair hand" do
      hand = Hand.new(onepair)
      expect(hand.is_flush?).to eq(false)
    end
  end

  describe "#is_pair?" do
    it "return true if hand has a pair" do
      hand = Hand.new(onepair)
      expect(hand.is_pair?).to eq(true)
    end

    it "return false if hand does not have pair" do
      hand = Hand.new(nada)
      expect(hand.is_pair?).to eq(false)
    end
  end

  describe "#is_two_pair?" do
    it "returns true if hand has two pair" do
      hand = Hand.new(twopair)
      expect(hand.is_two_pair?).to eq(true)
    end

    it "return false if hand has one pair" do
      hand = Hand.new(onepair)
      expect(hand.is_two_pair?).to eq(false)
    end
  end

  describe "#is_trips?" do
    it "returns true if hand has trips" do
      hand = Hand.new(trips)
      expect(hand.is_trips?).to eq(true)
    end

    it "returns false if hand has no trips" do
      hand = Hand.new(onepair)
      expect(hand.is_trips?).to eq(false)
    end
  end

  describe "#is_quads?" do
    it "returns true if hand has quads" do
      hand = Hand.new(quads)
      expect(hand.is_quads?).to eq(true)
    end

    it "returns false if hand does not have quads" do
      hand = Hand.new(onepair)
      expect(hand.is_quads?).to eq(false)
    end
  end

  describe "#is_fullhouse?" do
    it "returns true if house is full" do
      hand = Hand.new(fullhouse)
      expect(hand.is_fullhouse?).to eq(true)
    end

    it "returns false if house isn't full" do
      hand = Hand.new(onepair)
      expect(hand.is_fullhouse?).to eq(false)
    end
  end

end
