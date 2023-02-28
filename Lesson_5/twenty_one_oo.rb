require 'pry'

class TwentyOne
  attr_accessor :player, :dealer, :game_deck

  def initialize
    @player = Player.new
    @dealer = Dealer.new
    @game_deck = Deck.new
  end

  def initial_deal_cards
    2.times do
      player.cards << game_deck.deal_cards
      dealer.cards << game_deck.deal_cards
    end
  end

  def show_initial_cards
    clear
    player.show_initial_hand
    dealer.show_initial_hand
  end

  def player_turn
    loop do
      break if player.blackjack_check || player.busted?

      puts "Would you like to hit? (y/n)"
      answer = gets.chomp

      break if answer == 'n'
      clear
      player.cards << game_deck.deal_cards
      puts "#{player.name} hits!"
      puts ""
      player.display_cards
      dealer.show_initial_hand
    end
    player.stay
  end

  def dealer_turn
    loop do
      break if dealer.blackjack_check || dealer.busted? || dealer.stay
      clear
      dealer.cards << game_deck.deal_cards
      puts "#{dealer.name} hits!"
      puts ""
      dealer.display_cards
    end
  end

  def show_result
    clear
    puts "Final Result: "
    puts "--------------------------------"
    player.display_cards
    dealer.display_cards
    winner
  end

  def winner
    loop do
      break if anyone_busted?
      if player.total > dealer.total
        puts "#{player.name} wins!"
      elsif dealer.total > player.total
        puts "#{dealer.name} wins!"
      else
        puts "It's a push!"
      end
    end
  end

  def start
    loop do
      initial_deal_cards
      show_initial_cards
      player_turn
      dealer_turn
      show_result
      play_again? ? reset : break
    end
  end

  def clear
    system 'clear'
    game_header
  end

  def game_header
    puts "Welcome to Twenty-One!"
    puts ""
  end

  def display_cards
    puts "#{name} has the following cards for a total of #{total}: "
    puts "#{identify_cards}"
    puts "--------------------------------"
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include?(answer)
    end
    answer == 'y'
  end

  def reset
    player.cards = []
    dealer.cards = []
    self.game_deck = Deck.new
  end

  def anyone_busted?
    if player.busted?
      puts "#{player.name} busted! #{dealer.name} wins!"
    elsif dealer.busted?
      puts "#{dealer.name} busted! #{player.name} wins!"
    end
    player.busted? || dealer.busted?
  end
end

module Hand
  def identify_cards
    hand = []
    cards.each do |card|
      hand << [card.value, card.suit]
    end
    hand
  end

  def total
    total = 0
    values = cards.map(&:value)
    values.each do |value|
      if value == 'A'
        total += 11
      elsif value.to_i == 0
        total += 10
      else
        total += value.to_i
      end
    end

    values.select { |value| value == 'A' }.count.times do
      total -= 10 if total > 21
    end
    total
  end

  def busted?
    total > 21
  end

  def blackjack_check
    total == 21
  end
end

class Player < TwentyOne
  include Hand

  attr_accessor :cards, :name

  def initialize
    @cards = []
    @name = ""
    set_name
  end

  def stay
    puts "You have chosen to stay! Your final total is #{total}."
  end

  def show_initial_hand
    display_cards
  end

  def set_name
    name = nil
    loop do
      puts "What is your name?"
      name = gets.chomp
      break unless name.empty?
      puts "Sorry, you must enter a name."
    end
    self.name = name
  end
end

class Dealer < TwentyOne
  include Hand

  attr_accessor :cards, :name

  DEALER_NAMES = ['James Bond', 'Arnold', 'Rocky', 'Tom Cruise']

  def initialize
    @cards = []
    set_name
  end

  def stay
    total >= 17
  end

  def show_initial_hand
    puts "#{name} has the following card: "
    puts "#{identify_cards.first}"
    puts "--------------------------------"
  end

  def set_name
    self.name = DEALER_NAMES.sample
  end
end

class Deck
  attr_reader :cards

  def initialize
    @cards = []
    start_deck
  end

  def start_deck
    Card::SUITS.each do |suit|
      Card::VALUES.each do |value|
        @cards << Card.new(value, suit)
      end
    end
    @cards.shuffle!
  end

  def deal_cards
    cards.sample
  end
end

class Card < Deck
  include Hand
  attr_accessor :suit, :value

  SUITS = ['H', 'C', 'D', 'S']
  VALUES = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']

  def initialize(value, suit)
    @suit = suit
    @value = value
  end
end

TwentyOne.new.start
