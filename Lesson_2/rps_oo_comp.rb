require 'pry'

class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    greeting = "Welcome to Rock, Paper, Scissors, Spock, Lizard!"
    puts greeting
    puts "-" * greeting.size 
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors, Spock, Lizard. Good bye!"
  end

  def display_moves
    puts "-----------------------------------"
    puts "#{human.name} chose #{human.move}."
    puts "-----------------------------------"
    puts "#{computer.name} chose #{computer.move}."
    puts "-----------------------------------"
  end

  def display_winner

    if human.move > computer.move
      puts "********#{human.name} won!********"
    elsif human.move < computer.move
      puts "********#{computer.name} won!********"
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

  def display_history
    puts "-----------------------------------"
    puts "#{human.name} has picked the following historically: #{human.history}"
    puts "#{computer.name} has picked the following historically: #{computer.history}"
    puts "-----------------------------------"
  end

  def play
    display_welcome_message

    loop do
      human.choose
      computer.choose
      display_moves
      display_winner
      display_history
      break unless play_again?
      system('clear')
    end
    display_goodbye_message
  end
end

class Player
  attr_accessor :move, :name, :history

  def initialize
    set_name
    @history = []
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
      break if Move::VALUES_HUMAN.include?(choice)
      puts "Sorry, invalid choice."
    end
    self.move = Move.new(choice)
    self.history << choice
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def choose
    choice = Move::VALUES_COMP[name].sample
    self.move = Move.new(choice)
    self.history << choice
  end
end

class Move
  attr_accessor :value

  VALUES_HUMAN = ['rock', 'paper', 'scissors', 'lizard', 'spock']

  VALUES_COMP = {'R2D2' => ['rock'],
  'Hal' => ['scissors', 'scissors', 'scissors', 'rock', 'lizard'],
  'Chappie' => ['rock', 'rock', 'rock', 'spock', 'lizard', 'scissors'],
  'Sonny' => ['rock', 'paper', 'scissors', 'spock', 'lizard', 'lizard', 'lizard'],
  'Number 5' => ['rock', 'paper', 'spock', 'lizard', 'paper', 'paper']}

  WINNERS = {
    'rock' => ['scissors', 'lizard'],
    'paper' => ['rock', 'spock'],
    'scissors' => ['paper', 'lizard'],
    'spock' => ['rock', 'scissors'],
    'lizard' => ['spock', 'paper']
  }
  LOSERS = {
    'rock' => ['paper', 'spock'],
    'paper' => ['scissors', 'lizard'],
    'scissors' => ['rock', 'spock'],
    'spock' => ['paper', 'lizard'],
    'lizard' => ['rock', 'scissors']
  }

  def initialize(value)
    @value = value
  end

  def >(other_move)
    WINNERS[value].include?(other_move.value)
  end

  def <(other_move)
    LOSERS[value].include?(other_move.value)
  end

  def to_s
    @value
  end
end

RPSGame.new.play
