class Specialty
attr_reader :type, :doctors_id

  def initialize(type, doctors_id)
    @type = type
    @doctors_id = doctors_id
  end

  def self.all
    results = DB.exec("SELECT * FROM specialty;")
    types = []
    results.each do |specialties|
      type = specialties['type']
      doctors_id = specialties['doctors_id'].to_i
      types << Specialty.new(type, doctors_id)
    end
    types.each do |object|
      puts object.type.to_s
    end
  end

  def save
    results = DB.exec("INSERT INTO specialty (type, doctors_id) VALUES ('#{@type}', '#{@doctors_id}');")
  end

  def ==(another_patient)
    self.type == another_patient.type && self.doctors_id == another_patient.doctors_id
  end
end
