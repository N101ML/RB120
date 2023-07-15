class Rectangle
  @@total_area = 0

  def initialize(length, width)
    @length = length
    @width = width
    @@total_area += (length * width)
  end

  def self.total_area
    @@total_area
  end
end

rect1 = Rectangle.new(10, 15)
p Rectangle.total_area # 150
rect2 = Rectangle.new(12, 12)
p Rectangle.total_area # 294
