require 'rspec'
require 'deck'

describe Deck do

  subject { Deck.new }

  describe "#deck" do

    it "Should have 52 cards" do
      expect(subject.pack.length).to eq(52)
    end

    it "Should have 13 of each suit" do
      expect(
      Card.suits.all? do |test_suit|
        subject.pack.select {|card| card.suit == test_suit}.count == 13
      end
        ).to eq(true)
    end

    it "Should have 4 different suits of each value" do
      expect(
      Card.values.all? do |test_value|
        subject.pack.select {|card| card.value == test_value}.count == 4
      end
        ).to eq(true)
    end
  end

  describe "#deal_card" do
    it "Should deal 5 cards" do
      expect(subject.deal_card(5).length).to eq(5)
    end
    it "Should not deal more cards than are in the deck" do
      expect { subject.deal_card(500) }.to raise_error(OutofCardsError)
    end
    it "Should have 48 cards after dealing 4 cards" do
      subject.deal_card(4)
      expect(subject.pack.length).to eq(48)
    end
    it "Should return nil if given a nonpositive integer" do
      expect(subject.deal_card(4.5)).to eq(nil)
      expect(subject.deal_card(-5)).to eq(nil)
      expect(subject.deal_card(0)).to eq(nil)
    end
  end

  describe "#take_card" do
    let(:new_card) { Card.new(:hearts, :deuce) }
    it "Should return cards to the deck" do
      subject.take_card([new_card])
      expect(subject.pack.first).to eq(new_card)
      expect(subject.pack.length).to eq(53)
    end

    it "Does not accept mufflers, cards only" do
      expect { subject.take_card([343434]) }.to raise_error(NotACardError)
    end
  end


end
