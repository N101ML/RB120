module Swimmable
  def swim
    "I swim"
  end
end

class Mammal
  def body_temp
    'We are warm-blooded'
  end

  def habitat
    "We live almost anywhere"
  end

  def been_to_space
    'Not all of us'
  end
end

class Primate < Mammal
  def trait
    'We have opposable thumbs'
  end

  def habitat
    'We live in tropical forests mostly'
  end
end

class Human < Primate
  include Swimmable

  def habitat
    'We live in structures that we built'
  end

  def been_to_space
    'Yes we have!'
  end
end

class Gorilla < Primate
end

class Dolphin < Mammal
  include Swimmable

  def habitat
    'We live in the ocean'
  end
end

human = Human.new
gorilla = Gorilla.new
dolphin = Dolphin.new

p human.body_temp   # 'We are warm-blooded'
p gorilla.body_temp # 'We are warm-blooded'
p dolphin.body_temp # 'We are warm-blooded'

p human.trait   # 'We have opposable thumbs'
p gorilla.trait # 'We have opposable thumbs'
# p dolphin.trait # NoMethodError

p human.swim   # 'I swim'
# p gorilla.swim # NoMethodError
p dolphin.swim # 'I swim'

p human.habitat   # 'We live structures that we built'
p gorilla.habitat  # 'We live in tropical forests mostly'
p dolphin.habitat # 'We live in the ocean'

p human.been_to_space   # 'Yes we have!'
p gorilla.been_to_space # 'Not all of us'
p dolphin.been_to_space # 'Not all of us'
