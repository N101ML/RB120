module LightSpeed
  def drive
    puts "We go fast!"
  end
end

module RidiculousSpeed
  def drive
    puts "We go REAL fast!"
  end
end

module LudicrousSpeed
  def drive
    puts "WE'VE GONE PLAID!"
  end
end

class Spaceship
  def drive
    puts "We go!"
  end
end

class Spaceball < Spaceship
  include LudicrousSpeed
  include LightSpeed
  include RidiculousSpeed
end

spaceball_one = Spaceball.new
spaceball_one.drive
p Spaceball.ancestors
