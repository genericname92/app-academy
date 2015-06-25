require 'card'

class NotACardError < StandardError
end

class OutofCardsError < StandardError
end

class Deck
  attr_accessor :pack

  def initialize
    @pack = []
    Card.suits.each do |suit|
      Card.values.each do |value|
        @pack << Card.new(suit, value)
      end
    end
    @pack = @pack.shuffle
  end

  def deal_card(number)
    return nil if number < 1 || number.class != Fixnum
    raise OutofCardsError.new if number > @pack.length
    hand = []
    number.times do
      hand << @pack.pop
    end
    hand
  end

  def take_card(cards)
    raise NotACardError if cards.any? { |card| card.class != Card }
    cards.each { |card| @pack.unshift(card) }
    return true
  end

end
