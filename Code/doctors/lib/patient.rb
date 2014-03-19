class Patient
  attr_reader :name, :birthday, :doctors_id, :insurance_id

  def initialize(name, birthday, doctors_id, insurance_id)
    @name = name
    @birthday = birthday
    @doctors_id = doctors_id
    @insurance_id = insurance_id
  end

  def self.all
    results = DB.exec("SELECT * FROM patients;")
    patients = []
    results.each do |patient|
      name = patient['name']
      birthday = patient['birthday']
      doctors_id = patient['doctors_id'].to_i
      @insurance_id = patient['insurance_id'].to_i
      patients << Patient.new(name, birthday, doctors_id, @insurance_id)
    end
    patients.each do |object|
      puts "Name:" + " " + object.name.to_s + " | " + "Birthday:" + " " + object.birthday.to_s
    end
  end

  def save
    results = DB.exec("INSERT INTO patients (name, birthday, doctors_id, insurance_id) VALUES ('#{@name}', '#{@birthday}', '#{@doctors_id}, '#{@insurance_id}');")
  end

  def ==(another_patient)
    self.name == another_patient.name && self.birthday == another_patient.birthday && self.doctors_id == another_patient.doctors_id && self.insurance_id == another_patient.insurance_id
  end
end
