require 'pry'

class MinilangError < StandardError; end
class BadTokenError < MinilangError; end
class EmptyStackError < MinilangError; end

class Minilang
  ACTIONS = %w(push add sub mult div mod pop print)

  def initialize(instructions)
   @program = instructions
  end

  def eval(hash)
    @register = 0
    @stack = []
    @program.split.each do |token|
      eval_token(format(token, hash))
    end
  end

  def eval_token(token)
    if ACTIONS.include?(token.downcase)
      send token.downcase
    elsif token =~ /\A[-+]?\d+\z/
      @register = token.to_i
    else
      raise BadTokenError, "Invalid Token: #{token}"
    end
  end

  def print
    puts @register
  end

  def push
    @stack << @register
  end

  def mult
    @register *= @stack.pop
  end 

  def n(num)
    @register = num
  end

  def add
    @register += @stack.pop
  end

  def pop
    if @stack.empty?
      raise EmptyStackError, "Empty Stack!"
    end
    @register = @stack.pop
  end

  def div
    @register = @register / @stack.pop
  end

  def mod
    @register = @register % @stack.pop
  end

  def sub
    num = @stack.pop
    @register -= num
  end
end

# Minilang.new('PRINT').eval
# # 0

# Minilang.new('5 PUSH 3 MULT PRINT').eval
# # 15

# Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# # 5
# # 3
# # 8

# Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# # 10
# # 5

# # Minilang.new('5 PUSH POP POP PRINT').eval
# # Empty stack!

# Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# # 6

# Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# # 12

# # Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# # # Invalid token: XSUB

# Minilang.new('-3 PUSH 5 SUB PRINT').eval
# # 8

# Minilang.new('6 PUSH').eval
# # (nothing printed; no PRINT commands)

# CENTIGRADE_TO_FAHRENHEIT =
#   '5 PUSH %<degrees_c>d PUSH 9 MULT DIV PUSH 32 ADD PRINT'
# Minilang.new(format(CENTIGRADE_TO_FAHRENHEIT, degrees_c: 100)).eval
# # 212
# Minilang.new(format(CENTIGRADE_TO_FAHRENHEIT, degrees_c: 0)).eval
# # 32
# Minilang.new(format(CENTIGRADE_TO_FAHRENHEIT, degrees_c: -40)).eval
# # -40

# CENTIGRADE_TO_FAHRENHEIT =
#   '5 PUSH %<degrees_c>d PUSH 9 MULT DIV PUSH 32 ADD PRINT'
# minilang = Minilang.new(CENTIGRADE_TO_FAHRENHEIT)
# minilang.eval(degrees_c: 100)
# 212
# minilang.eval(degrees_c: 0)
# # 32
# minilang.eval(degrees_c: -40)
# # -40

# FARENHEIT_TO_CENTIGRADE = 
#   '9 PUSH 32 PUSH %<degrees_f>d SUB PUSH 5 MULT DIV PRINT'

# minilang = Minilang.new(FARENHEIT_TO_CENTIGRADE)
# minilang.eval(degrees_f: 122)

# MPH_TO_KPH = 
#   "3 PUSH %<speed_mph>d PUSH 5 MULT DIV PRINT"

# minilang = Minilang.new(MPH_TO_KPH)
# minilang.eval(speed_mph: 100)

AREA_OF_TRIANGLE = 
  ""
