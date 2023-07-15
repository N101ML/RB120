module Throwable
  def throw_ball
    puts "I throw a ball!"
  end
end

class Athlete
end

class Basketballer < Athlete
  include Throwable
end

class Footballer < Athlete
  include Throwable
end

class Boxer < Athlete
  def throw_punch
    puts "I throw a punch!"
  end
end

Basketballer.new.throw_ball # I throw a ball!
Footballer.new.throw_ball   # I throw a ball!
Boxer.new.throw_punch       # I throw a punch!
