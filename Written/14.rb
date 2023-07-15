class Vehicle
end

class LandVehicle < Vehicle
end

class Automobile < LandVehicle
end

class ElectricAutomobile < Automobile
  attr_reader :make, :model

  def initialize(make, model)
    @make = make
    @model = model
  end

  def ==(other)
    make == other.make && model == other.model
  end
end

make = 'Tesla'
model = 'Model S'
black_tesla = ElectricAutomobile.new(make, model)
blue_tesla = ElectricAutomobile.new(make, model)

p black_tesla == blue_tesla # false
