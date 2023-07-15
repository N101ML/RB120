require 'pry'

class GuessingGame

  def initialize(low_end, high_end)
    @guess = nil
    @range = (low_end..high_end)
    @guesses_left = Math.log2(@range.size).to_i + 1
  end

  def play
    reset
    loop do
      guess
      break if out_of_guesses || winner?
      feedback
    end
    result
  end

  def reset
    @winning_number = rand(@range)
  end

  def winner?
    @guess == @winning_number
  end

  def guess
    puts "You have #{@guesses_left} guesses remaining."
    puts "Enter a number between #{@range.first} and #{@range.last}: "
    loop do
      @guess = gets.chomp.to_i
      break if (@range).include?(@guess)
      puts "Invalid guess. Enter a number between #{@range.first} and #{@range.last}:"
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

game = GuessingGame.new(501, 1500)
game.play
