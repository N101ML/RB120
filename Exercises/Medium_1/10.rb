require 'pry'

class Card
  include Comparable
  attr_reader :rank, :suit

  VALUES = {'Jack' => 11, 'Queen' => 12, 'King' => 13, 'Ace' => 14}

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def to_s
    "#{rank} of #{suit}"
  end

  def value
    VALUES.fetch(rank, rank)
  end

  def <=>(other_card)
    value <=> other_card.value
  end
end

class Deck
  attr_accessor :cards
  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  def initialize
    reset
  end

  def new_deck
    temp_deck = []
    SUITS.each do |suit|
      RANKS.each do |rank|
        temp_deck << Card.new(rank, suit)
      end
    end
    temp_deck
  end

  def reset
    @cards = new_deck
    shuffle_deck
  end

  def shuffle_deck
    cards.shuffle!
  end

  def draw
    reset if @cards.empty?
    @cards.pop
  end
end

class PokerHand
  def initialize(deck)
    @hand = []
    @deck = deck
    deal
  end

  def deal
    5.times do
      @hand << @deck.draw
    end
  end

  def print
    @hand.each do |card| 
      puts card
    end
  end

  def evaluate
    case
    when royal_flush?     then 'Royal flush'
    when straight_flush?  then 'Straight flush'
    when four_of_a_kind?  then 'Four of a kind'
    when full_house?      then 'Full house'
    when flush?           then 'Flush'
    when straight?        then 'Straight'
    when three_of_a_kind? then 'Three of a kind'
    when two_pair?        then 'Two pair'
    when pair?            then 'Pair'
    else                       'High card'
    end
  end

  private

  def royal_flush?
    rf_hand = ['Ace', 'King', 'Queen', 'Jack', 10]

    if flush?
      if @hand.all? { |card| rf_hand.include?(card.rank) }
        binding.pry
        return true
      end
    end
    false
  end

  def straight_flush?
    flush? && straight?
  end

  def four_of_a_kind?
    pairs(4)
  end

  def full_house?
    pairs(3) && pairs(2)
  end

  def flush?
    @hand.all? { |card| card.suit == @hand[0].suit }
  end

  def straight?
    sorted = @hand.sort_by { |card| card.value }
    start = sorted[0].value
    count = 0
    sorted.each do |card|
      if (card.value - start) == count
        count += 1
      else
        return false
      end
    end
    true
  end

  def three_of_a_kind?
    pairs(3)
  end

  def two_pair?
    count = 0
    arr = []
    @hand.each do |card|
      arr << card.value
    end
    arr.uniq.each do |num|
      if arr.count(num) == 2
        count += 1
      end
    end
    count == 2 ? (return true) : (return false)
  end

  def pair?
    pairs(2)
  end

  def pairs(type)
    arr = []
    @hand.each do |card|
      arr << card.value
    end
    arr.uniq.each do |num|
      if arr.count(num) == type
        return true
      end
    end
    false
  end
end

array = []
hash = {}

100000.times do 
  hand = PokerHand.new(Deck.new)
  array << hand.evaluate
end

array.uniq.each do |result|
  hash[result] = array.count(result)
end

p hash

# Danger danger danger: monkey
# patching for testing purposes.
class Array
  alias_method :draw, :pop
end

# Test that we can identify each PokerHand type.
# hand = PokerHand.new([
#   Card.new(10,      'Hearts'),
#   Card.new('Ace',   'Hearts'),
#   Card.new('Queen', 'Hearts'),
#   Card.new('King',  'Hearts'),
#   Card.new('Jack',  'Hearts')
# ])
# puts hand.evaluate == 'Royal flush'

# hand = PokerHand.new([
#   Card.new(8,       'Clubs'),
#   Card.new(9,       'Clubs'),
#   Card.new('Queen', 'Clubs'),
#   Card.new(10,      'Clubs'),
#   Card.new('Jack',  'Clubs')
# ])
# puts hand.evaluate == 'Straight flush'

# hand = PokerHand.new([
#   Card.new(3, 'Hearts'),
#   Card.new(3, 'Clubs'),
#   Card.new(5, 'Diamonds'),
#   Card.new(3, 'Spades'),
#   Card.new(3, 'Diamonds')
# ])
# puts hand.evaluate == 'Four of a kind'

# hand = PokerHand.new([
#   Card.new(3, 'Hearts'),
#   Card.new(3, 'Clubs'),
#   Card.new(5, 'Diamonds'),
#   Card.new(3, 'Spades'),
#   Card.new(5, 'Hearts')
# ])
# puts hand.evaluate == 'Full house'

# hand = PokerHand.new([
#   Card.new(10, 'Hearts'),
#   Card.new('Ace', 'Hearts'),
#   Card.new(2, 'Hearts'),
#   Card.new('King', 'Hearts'),
#   Card.new(3, 'Hearts')
# ])
# puts hand.evaluate == 'Flush'

# hand = PokerHand.new([
#   Card.new(8,      'Clubs'),
#   Card.new(9,      'Diamonds'),
#   Card.new(10,     'Clubs'),
#   Card.new(7,      'Hearts'),
#   Card.new('Jack', 'Clubs')
# ])
# puts hand.evaluate == 'Straight'

# hand = PokerHand.new([
#   Card.new('Queen', 'Clubs'),
#   Card.new('King',  'Diamonds'),
#   Card.new(10,      'Clubs'),
#   Card.new('Ace',   'Hearts'),
#   Card.new('Jack',  'Clubs')
# ])
# puts hand.evaluate == 'Straight'

# hand = PokerHand.new([
#   Card.new(3, 'Hearts'),
#   Card.new(3, 'Clubs'),
#   Card.new(5, 'Diamonds'),
#   Card.new(3, 'Spades'),
#   Card.new(6, 'Diamonds')
# ])
# puts hand.evaluate == 'Three of a kind'

# hand = PokerHand.new([
#   Card.new(9, 'Hearts'),
#   Card.new(9, 'Clubs'),
#   Card.new(5, 'Diamonds'),
#   Card.new(8, 'Spades'),
#   Card.new(5, 'Hearts')
# ])
# puts hand.evaluate == 'Two pair'

# hand = PokerHand.new([
#   Card.new(2, 'Hearts'),
#   Card.new(9, 'Clubs'),
#   Card.new(5, 'Diamonds'),
#   Card.new(9, 'Spades'),
#   Card.new(3, 'Diamonds')
# ])
# puts hand.evaluate == 'Pair'

# hand = PokerHand.new([
#   Card.new(2,      'Hearts'),
#   Card.new('King', 'Clubs'),
#   Card.new(5,      'Diamonds'),
#   Card.new(9,      'Spades'),
#   Card.new(3,      'Diamonds')
# ])
# puts hand.evaluate == 'High card'
