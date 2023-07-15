require 'pry'

class GuessingGame
  MAX_GUESSES = 7
  RANGE = 1..100

  def initialize
    @guesses_left = MAX_GUESSES
    @guess = nil
  end

  def play
    @winning_number = rand(RANGE)
    loop do
      guess
      break if out_of_guesses || winner?
      feedback
    end
    result
  end

  def winner?
    @guess == @winning_number
  end

  def guess
    puts "You have #{@guesses_left} guesses remaining."
    puts "Enter a number between #{RANGE.first} and #{RANGE.last}: "
    loop do
      @guess = gets.chomp.to_i
      break if (RANGE).include?(@guess)
      puts "Invalid guess. Enter a number between #{RANGE.first} and #{RANGE.last}:"
    end
    @guesses_left -= 1
  end

  def out_of_guesses
    @guesses_left == 0 
  end

  def feedback
    if @guess > @winning_number
      puts "Your guess is too high."
    elsif @guess < @winning_number
      puts "Your guess is too low."
    else
      puts "That's the number!"
    end
  end

  def result
    winner? ? puts("You won!") : puts("You have no more guesses. You lost! The number was #{@winning_number}")
  end
end

game = GuessingGame.new
game.play
