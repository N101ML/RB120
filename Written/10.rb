class Company
  def initialize
    @employees = [Manager.new, Engineer.new, Intern.new]
  end

  def work_day
    @employees.each do |employee|
      employee.work
    end
  end
end

class Manager
  def work
    puts "I'm delegating"
  end
end

class Engineer
  def work
    puts "I'm writing code"
  end
end

class Intern
  def work
    puts "I'm getting coffee"
  end
end

company = Company.new
company.work_day

p Manager.ancestors
