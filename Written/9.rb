class Employee
  def initialize(name, ssn)
    @name = name
    @ssn = ssn
  end

  def employee_info
    puts "Employee Info:\nName: #{name}\nSSN: #{ssn}"
  end

  def confirm_employee(given_name, given_ssn)
    name == given_name && ssn == given_ssn
  end

  private

  attr_reader :name, :ssn
end

jill = Employee.new('Jill', '145-66-9102')
jill.employee_info # Employee Info:
                    # Name: Jill
                   # SSN: 145-66-9102
jill.confirm_employee('Jill', 'not a ssn') # false
jill.confirm_employee('Jill', '145-66-9102') # true
jill.name # NoMethodError
jill.ssn # NoMethodError
