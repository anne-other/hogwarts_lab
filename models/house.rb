require_relative('../db/sql_runner.rb')

class House

  attr_reader :id
  attr_accessor :name, :logo

  def initialize(options)
    @id = options['id'].to_i() if options['id']
    @name = options['name']
    @logo = options['logo']
  end

  def save()
    sql = "INSERT INTO houses
    (
      name,
      logo
      )
      VALUES
      (
        $1, $2
        )
        RETURNING id"
    values = [@name, @logo]
    house_data = SqlRunner.run(sql, values)
    @id = house_data.first()['id'].to_i()
  end

  def self.all()
    sql = "SELECT * FROM houses"
    houses = SqlRunner.run(sql)
    return houses.map { |house| House.new(house) }
  end

  def self.find(id)
    sql = "SELECT * FROM houses WHERE id = $1"
    values = [id]
    house = SqlRunner.run(sql, values)
    return House.new(house.first)
  end

  def self.delete_all()
    sql = "DELETE FROM houses"
    SqlRunner.run(sql)
  end

end
