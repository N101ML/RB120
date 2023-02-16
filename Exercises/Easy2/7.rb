require 'pry'

class Pet
  attr_reader :animal, :breed
  @@pets_total = 0

  def initialize(animal, breed)
    @animal = animal
    @breed = breed
    @@pets_total += 1
  end

  def to_s
    "a #{animal} named #{breed}"
  end

  def self.change_total(value)
    @@pets_total += value
  end

  def self.view_total
    @@pets_total
  end
end

class Owner
  attr_reader :name
  attr_accessor :pets

  def initialize(name)
    @name = name
    @pets = []
  end

  def add_pet(pet)
    @pets << pet
  end

  def number_of_pets
    @pets.size
  end

  def print_pets
    puts pets
  end

  def self.pets_total
    @@pets_total
  end
end

class Shelter

  def initialize
    @owners = {}
  end

  def adopt(owner_obj, pet_obj)
    owner_obj.add_pet(pet_obj)
    @owners[owner_obj.name] ||= owner_obj
    Pet.change_total(-1)
  end

  def print_adoptions
    @owners.each do |name, owner|
      puts "#{name} has adopted the following pets:"
      owner.print_pets
      puts
    end
  end

end

## Adding all of the pets to the shelter as Pet objects
butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')
asta         = Pet.new('dog', 'Asta')
laddie       = Pet.new('dog', 'Laddie')
fluffy       = Pet.new('cat', 'Fluff')
kat          = Pet.new('cat', 'Kat')
ben          = Pet.new('cat', 'Ben')
chatterbox   = Pet.new('parakeet', 'Chatterbox')
bluebell     = Pet.new('parakeet', 'Bluebell')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)
shelter.print_adoptions
puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."
puts "The Animal shelter has #{Pet.view_total} unadopted pets."
