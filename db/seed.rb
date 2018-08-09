require('pry')
require_relative('../models/student.rb')

Student.delete_all()

student1 = Student.new(
  {
    'first_name' => "Harry",
    'second_name' => "Potter",
    'house' => "Gryffindor",
    'age' => "11"
  }
)

student2 = Student.new(
  {
    'first_name' => "Draco",
    'second_name' => "Malfoy",
    'house' => "Slytherin",
    'age' => "11"
  }
)

student1.save()
student2.save()


# binding.pry
# nil
