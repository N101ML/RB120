class Celebrity
  attr_reader :name
  def initialize(name, net_worth, agent)
    @name = name
    @net_worth = net_worth
    @agent = agent
  end

  def wealthy?
    net_worth > 1_000_000
  end

  def same_agent?(other_celeb)
    agent == other_celeb.agent
  end

  private 

  attr_reader :net_worth

  protected

  attr_reader :agent
end

snoop = Celebrity.new('Snoop Dogg', 160_000_000, 'Michelle Smith')
martha = Celebrity.new('Martha Stewart', 400_000_000, 'Rich Dobbs')

p snoop.name # Snoop Dogg
p snoop.wealthy? # true
p snoop.same_agent?(martha) # false
p snoop.net_worth # NoMethodError
p snoop.agent #NoMethodError
