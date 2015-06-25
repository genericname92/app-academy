require 'deck'

class Hand
  HAND_STRENGTH = { :kicker => 0,
                    :single_pair => 1,
                    :two_pair => 2,
                    :triples => 3,
                    :straight => 4,
                    :flush => 5,
                    :full_house => 6,
                    :quads => 7,
                    :straight_flush => 8
                    }


  def initialize(cards)
    @hand = cards
  end

  def self.compare(other_hand)

  end
  def evaluate_hand
    return HAND_STRENGTH[:straight_flush] if is_straight_flush?
    return HAND_STRENGTH[:quads] if is_quads?
    return HAND_STRENGTH[:full_house] if is_fullhouse?
    return HAND_STRENGTH[:flush] if is_flush?
    return HAND_STRENGTH[:straight] if is_straight?
    return HAND_STRENGTH[:triples] if is_trips?
    return HAND_STRENGTH[:two_pair] if is_two_pair?
    return HAND_STRENGTH[:single_pair] if is_pair?
    return HAND_STRENGTH[:kicker]
  end

  def is_pair?
    raise "Hand is not five cards" if @hand.length != 5
    (0...@hand.length).each do |idx1|
      (idx1+1...@hand.length).each do |idx2|
        return true if @hand[idx1].value == @hand[idx2].value
      end
    end
    false
  end

  def is_straight?
    raise "Hand is not five cards" if @hand.length != 5
    sort!
    (0..3).each do |x|
      return false unless @hand[x].poker_value + 1 == @hand[x + 1].poker_value
    end
    @highest_relevant_card = @hand[4]
    true
  end

  def is_two_pair?
    raise "Hand is not five cards" if @hand.length != 5
    sort!
    count = 0
    Card.values.each do |value|
      count += 1 if @hand.select {|card| card.value == value}.count >= 2
    end
    return true if count >= 2
    false
  end

  def is_trips?
    Card.values.each do |value|
      return true if @hand.select {|card| card.value == value}.count == 3
    end
    false
  end

  def is_quads?
    Card.values.each do |value|
      return true if @hand.select {|card| card.value == value}.count == 4
    end
    false
  end

  def is_fullhouse?
    is_trips? && is_two_pair?
  end

  def is_straight_flush?
    is_flush? && is_straight?
  end

  def is_flush?
    raise "Hand is not five cards" if @hand.length != 5
    sort!
    return false unless @hand.all? { |card| card.suit == @hand[0].suit }
    @highest_relevant_card = @hand[4]
    true
  end

#Must sort for frequency after value
  def sort!
    @hand = @hand.sort { |x, y| x.poker_value <=> y.poker_value }
  end

  def discard
  end

  def draw
  end
end
