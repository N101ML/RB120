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

deck = Deck.new

drawn = []
52.times { drawn << deck.draw }
p drawn.count { |card| card.rank == 5 } == 4
p drawn.count { |card| card.suit == 'Hearts' } == 13

drawn2 = []
52.times { drawn2 << deck.draw }

p drawn != drawn2 # Almost always.
