require 'spec_helper'


describe Insurance do
  it 'is initialized with a type and doctor_id' do
    insurance = Insurance.new('Red Shield', 1)
    insurance.should be_an_instance_of Insurance
  end

  it 'tells you its type' do
    insurance = Insurance.new('Red Shield', 1)
    insurance.company.should eq 'Red Shield'
  end

  it 'starts off with no companies' do
    Insurance.all.should eq []
  end

  it 'lets you save tasks to the database' do
    insurance = Insurance.new('Red Shield', 1)
    insurance.save
    Insurance.all.should eq [insurance]
  end

  it 'is the same task if it has the same name' do
    insurance1 = Insurance.new('Red Shield', 1)
    insurance2 = Insurance.new('Red Shield', 1)
    insurance1.should eq insurance2
  end
end
