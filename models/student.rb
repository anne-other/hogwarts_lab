require_relative('../db/sql_runner.rb')
require_relative('../models/house.rb')

class Student

  attr_reader :id
  attr_accessor :first_name, :second_name, :house_id, :age

  def initialize(options)
    @id = options['id'].to_i() if options['id']
    @first_name = options['first_name']
    @second_name = options['second_name']
    @house_id = options['house_id'].to_i()
    @age = options['age'].to_i()
  end

  def save()
    sql = "INSERT INTO students
    (
      first_name,
      second_name,
      house_id,
      age
      )
      VALUES
      (
        $1, $2, $3, $4
        )
        RETURNING id"
      values = [@first_name, @second_name, @house_id, @age]
      student_data = SqlRunner.run(sql, values)
      @id = student_data.first()['id'].to_i()
  end

  def self.delete_all()
    sql = "DELETE FROM students"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM students"
    students = SqlRunner.run(sql)
    return students.map { |student| Student.new(student) }
  end

  def self.find(id)
    sql = "SELECT * FROM students WHERE id = $1"
    values = [id]
    student = SqlRunner.run(sql, values)
    return Student.new(student.first)
  end

  def find_house_for_student
      sql = "SELECT * from houses where id  = $1"
      values = [@house_id]
      house_find = SqlRunner.run(sql, values)
      return House.new(house_find.first)

  end

end
