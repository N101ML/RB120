class Person
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def self.fact
    "Cogito ero sum"
  end

  def rename=(new_name)
    self.name = new_name
  end

  private

  attr_writer :name
end

person = Person.new('Tina')

p Person.fact # "Cogito ero sum"
p person.name # 'Tina'
p person.rename = 'Mandy'
p person.name # 'Mandy'
