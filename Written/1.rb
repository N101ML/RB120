class Superhero
  attr_reader :name, :use_powers
  def initialize(name, use_powers)
    @name = name
    @use_powers = use_powers
  end

  def exclaim
    "I'm a superhero!"
  end
end

batman = Superhero.new('Batman', 'kicky-punches')
storm = Superhero.new('Storm', 'tornado control')
p batman.name       # "Batman"
p storm.name        # "Storm"
p batman.use_powers # "kicky-punches"
p storm.use_powers  # "tornado control"
p batman.exclaim    # "I'm a superhero!"
p storm.exclaim     # "I'm a superhero!"
