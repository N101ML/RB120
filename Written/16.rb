module Flyable
  def fly
  end
end

module Sociable
  def social
  end
end

module Huntable
  def hunt(prey)
  end
end

class Zoo
  @@total_animals = 0

  def self.assign_id
    @@total_animals += 1
  end
end

class Animal
  def initialize
    @animal_id = Zoo.assign_id
    @weight = calc_weight(self.class::UPPER_WEIGHT, self.class::LOWER_WEIGHT)
    @body_temp = 'warm-blooded'
  end

  def to_s
    <<~ANIMAL_OUTPUT
    ========================
    species: #{self.class}
    animal id: #{animal_id}
    weight: #{weight}
    diet: #{diet}
    body temp: #{body_temp}
    ========================
    ANIMAL_OUTPUT
  end

  private

  attr_reader :animal_id, :weight, :diet, :body_temp

  def calc_weight(top_range, bottom_range)
    rand(top_range..bottom_range)
  end
end

class Herbivore < Animal
  def initialize
    super
    @diet = "vegetation"
  end
end

class Carnivore < Animal
  def initialize
    super
    @diet = "meat"
  end
end

class Zebra < Herbivore
  include Sociable

  UPPER_WEIGHT = 770
  LOWER_WEIGHT = 990
end

class Hawk < Carnivore
  include Flyable
  include Huntable

  UPPER_WEIGHT = 12
  LOWER_WEIGHT = 15
end

class Tiger < Carnivore
  include Huntable

  UPPER_WEIGHT = 200
  LOWER_WEIGHT = 680
end

class Koala < Herbivore

  UPPER_WEIGHT = 10
  LOWER_WEIGHT = 30
end

class Parrot < Herbivore
  include Flyable
  include Sociable

  UPPER_WEIGHT = 1
  LOWER_WEIGHT = 3
end

zeb = Zebra.new
tig = Tiger.new
koa = Koala.new
hawk = Hawk.new
par = Parrot.new

puts zeb
puts tig
puts koa
puts hawk
puts par
