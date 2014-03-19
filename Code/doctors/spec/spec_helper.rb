require 'rspec'
require 'pg'
require 'doctor'
require 'patient'
require 'specialty'
require 'insurance'

DB = PG.connect(:dbname => 'doctor_test')


RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM doctors *;")
    DB.exec("DELETE FROM patients *;")
    DB.exec("DELETE FROM specialty *;")
    DB.exec("DELETE FROM insurance *;")
  end
end

