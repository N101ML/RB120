class House
  def initialize(color)
   @color = color
  end

  def color
    @color
  end

  def color=(value)
    @color = value
  end
end

gray_house = House.new('Gray')
p gray_house.color # Gray
p gray_house.color = 'Orange'
p gray_house.color # Orange
