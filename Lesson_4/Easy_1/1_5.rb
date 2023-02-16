class Fruit
  def initialize(name)
    name = name
  end
end

class Pizza
  def initialize(name)
    @name = name
  end
end

lemon = Fruit.new("lemon")
cheese =  Pizza.new("cheese")

p lemon.instance_variables
p cheese.instance_variables
