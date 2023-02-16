class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
    @@winner = nil
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors! The first player to 10 wins!"
  end

  def display_goodbye_message
    puts "#{winner} won! Thanks for playing Rock, Paper, Scissors. Good bye!"
  end

  def display_moves
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
  end

  def display_winner
    if human.move > computer.move
      puts "#{human.name} won!"
      human.score += 1
    elsif human.move < computer.move
      puts "#{computer.name} won!"
      computer.score += 1
    else
      puts "It's a tie!"
    end

    def winner
      @@winner
    end
  end

  def play_again?
    puts "The current score is:"
    puts "#{human.name}: #{human.score}"
    puts "#{computer.name}: #{computer.score}"

    if computer.score == 10
      @@winner = computer.name
      return false
    elsif human.score == 10
      @@winner = human.name
      return false
    end

    return true
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
  attr_accessor :move, :name, :score

  def initialize
    set_name
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
    self.score = 0
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, or scissors: "
      choice = gets.chomp
      break if Move::VALUES.include?(choice)
      puts "Sorry, invalid choice."
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player

  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
    self.score = 0
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end

class Move
  VALUES = ['rock', 'paper', 'scissors']

  def initialize(value)
    @value = value
  end

  def scissors?
    @value == 'scissors'
  end

  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
  end

  def >(other_move)
    (rock? && other_move.scissors?) ||
      (paper? && other_move.rock?) ||
      (scissors? && other_move.paper?)
  end

  def <(other_move)
    (rock? && other_move.paper?) ||
      (paper? && other_move.scissors?) ||
      (scissors? && other_move.rock?)
  end

  def to_s
    @value
  end

end

RPSGame.new.play
