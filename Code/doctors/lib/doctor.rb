class Doctor

  attr_reader :name

  def initialize(name)
    @name = name
  end

  def id
    @id
  end

  def self.all
    results = DB.exec("SELECT * FROM doctors;")
    doctors = []
    results.each do |result|
      name = result['name']
      id = result['id'].to_i
      doctors << Doctor.new(name)
    end
    doctors.each do |object|
      puts object.id.to_s + object.name.to_s
    end
  end

  def save
  results = DB.exec("INSERT INTO doctors (name) VALUES ('#{@name}') RETURNING id;")
  @id = results.first['id'].to_i
  end

  def ==(another_doctor)
    self.name == another_doctor.name
  end
end
