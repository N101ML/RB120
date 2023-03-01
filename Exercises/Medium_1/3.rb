class Student
  def initialize(name, year)
    @name = name
    @year = year
  end
end

class Graduate < Student
  def initialize(name, year, parking)
    super(name, year)
    @parking = parking
  end
end

class Undergraduate < Student
end

a = Student.new('Bill', 2020)
b = Graduate.new('Rob', 2020, 'Lot C')
c = Undergraduate.new('Lisa', 2025)

p a
p b
p c
