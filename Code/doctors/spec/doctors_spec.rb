require 'spec_helper'

describe Doctor do
  it 'is initialized with a name' do
    doctor = Doctor.new('Dr. Phil')
    doctor.should be_an_instance_of Doctor
  end


  it 'tells you its name' do
    doctor = Doctor.new('Dr. Phil')
    doctor.name.should eq 'Dr. Phil'
  end

  it 'starts off with no doctors' do
    Doctor.all.should eq []
  end

  it 'lets you save tasks to the database' do
    doctor = Doctor.new('Dr. Phil')
    doctor.save
    Doctor.all.should eq [doctor]
  end

  it 'is the same task if it has the same name' do
    doctor1 = Doctor.new('Dr. Phil')
    doctor2 = Doctor.new('Dr. Phil')
    doctor1.should eq doctor2
  end
end
