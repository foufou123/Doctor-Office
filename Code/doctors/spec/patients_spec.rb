require 'spec_helper'

describe Patient do
  it 'is initialized with a name and birthday and doctor_id' do
    patient = Patient.new('Joe Bob', '10/10/2000', 1)
    patient.should be_an_instance_of Patient
  end

  it 'tells you its name' do
    patient = Patient.new('Joe Bob', '10/10/2000', 1)
    patient.name.should eq 'Joe Bob'
  end

  it 'starts off with no patient' do
    Patient.all.should eq []
  end

  it 'lets you save tasks to the database' do
    patient = Patient.new('Joe Bob', '10/10/2000', 1)
    patient.save
    Patient.all.should eq [patient]
  end

  it 'is the same task if it has the same name' do
    patient1 = Patient.new('Joe Bob', '10/10/2000', 1)
    patient2 = Patient.new('Joe Bob', '10/10/2000', 1)
    patient1.should eq patient2
  end
end
