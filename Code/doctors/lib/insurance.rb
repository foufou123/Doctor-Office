class Insurance
attr_reader :company

  def initialize(company)
    @company = company
  end

  def self.all
    results = DB.exec("SELECT * FROM insurance;")
    companies = []
    results.each do |company|
      name = company['company']
      companies << Insurance.new(name)
    end
    companies.each do |object|
      puts object.company.to_s
    end
  end

  def save
    results = DB.exec("INSERT INTO insurance (company, patient_id) VALUES ('#{@company}', '#{@patient_id}');")
  end

  def ==(another_patient)
    self.company == another_patient.company && self.patient_id == another_patient.patient_id
  end
end
