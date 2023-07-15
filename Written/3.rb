require 'pry'

class Student
  attr_accessor :full_name, :student_id

  def initialize(full_name, student_id)
    @full_name = full_name
    @student_id = student_id
  end

  def format_full_name
    formatted_name = full_name.split(' ').map do |name|
      name.capitalize
    end.join(' ')
    self.full_name = formatted_name
  end
end

gwen = Student.new('gwen lucy richards', 123456768)
p gwen.full_name # gwen lucy richards
p gwen.format_full_name # Gwen Lucy Richards
p gwen.full_name # Gwen Lucy Richards
