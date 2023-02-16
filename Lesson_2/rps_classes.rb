require 'pry'

class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "Hi #{human.name}! Welcome to Rock, Paper, Scissors, Spock, Lizard!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors, Spock, Lizard. Good bye!"
  end

  def display_moves
    puts "#{human.name} chose #{human.move.name}."
    puts "#{computer.name} chose #{computer.move.name}."
  end

  def display_winner
    if human.move > computer.move
      puts "#{human.name} won!"
    elsif human.move < computer.move
      puts "#{computer.name} won!"
    else
      puts "It's a tie!"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include?(answer.downcase)
      puts "Sorry, must be y or n"
    end

    return false if answer.downcase == 'n'
    return true if answer.downcase == 'y'
  end

  def play
    display_welcome_message

    loop do
      human.choose
      computer.choose
      display_moves
      display_winner
      break unless play_again?
    end
    display_goodbye_message
  end
end

class Player
  attr_accessor :move, :name

  def initialize
    set_name
  end

  def find_class(choice)
    case choice
    when 'rock'
      self.move = Rock.new('rock')
    when 'paper'
      self.move = Paper.new('paper')
    when 'scissors'
      self.move = Scissors.new('scissors')
    when 'spock'
      self.move = Spock.new('spock')
    when 'lizard'
      self.move = Lizard.new('lizard')
    end
  end
end

class Human < Player
  def set_name
    n = ""
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Sorry, must enter a value."
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, scissors, spock or lizard: "
      choice = gets.chomp
      break if Move::VALUES.include?(choice)
      puts "Sorry, invalid choice."
    end

    find_class(choice)
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def choose
    find_class(Move::VALUES.sample)
  end
end

class Move
  attr_accessor :value

  VALUES = ['rock', 'paper', 'scissors', 'spock', 'lizard']

  def to_s
    @value
  end
end

class Rock < Move
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def >(other_move)
    WINNERS.include?(other_move.name)
  end

  def <(other_move)
    LOSERS.include?(other_move.name)
  end

  WINNERS = ['scissors', 'lizard']
  LOSERS = ['paper', 'spock']
end

class Paper < Move
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def >(other_move)
    WINNERS.include?(other_move.name)
  end

  def <(other_move)
    LOSERS.include?(other_move.name)
  end

  WINNERS = ['rock', 'spock']
  LOSERS = ['scissors', 'lizard']
end

class Scissors < Move
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def >(other_move)
    WINNERS.include?(other_move.name)
  end

  def <(other_move)
    LOSERS.include?(other_move.name)
  end

  WINNERS = ['paper', 'lizard']
  LOSERS = ['rock', 'spock']
end

class Lizard < Move
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def >(other_move)
    WINNERS.include?(other_move.name)
  end

  def <(other_move)
    LOSERS.include?(other_move.name)
  end

  WINNERS = ['spock', 'paper']
  LOSERS = ['rock', 'scissors']
end

class Spock < Move
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def >(other_move)
    WINNERS.include?(other_move.name)
  end

  def <(other_move)
    LOSERS.include?(other_move.name)
  end

  WINNERS = ['rock', 'scissors']
  LOSERS = ['paper', 'lizard']
end

RPSGame.new.play
