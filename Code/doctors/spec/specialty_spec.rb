require 'spec_helper'

describe Specialty do
  it 'is initialized with a type and doctor_id' do
    specialty = Specialty.new('Psychiatrist', 1)
    specialty.should be_an_instance_of Specialty
  end

  it 'tells you its type' do
    specialty = Specialty.new('Psychiatrist', 1)
    specialty.type.should eq 'Psychiatrist'
  end

  it 'starts off with no specialty' do
    Specialty.all.should eq []
  end

  it 'lets you save tasks to the database' do
    specialty = Specialty.new('Psychiatrist', 1)
    specialty.save
    Specialty.all.should eq [specialty]
  end

  it 'is the same task if it has the same name' do
    specialty1 = Specialty.new('Psychiatrist', 1)
    specialty2 = Specialty.new('Psychiatrist', 1)
    specialty1.should eq specialty2
  end
end
