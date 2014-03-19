require 'pg'
require './lib/doctor'
require './lib/patient'
require './lib/insurance'
require './lib/specialty'

DB = PG.connect({:dbname => 'doctors_office'})

def prompt
  print '>'
end

def main_menu
  puts "\n"
  puts "Welcome to the your Doctor office App!"
  puts "\n"
  puts "Press 'a' to view all Doctors at the office"
  puts "Press 'b' to enter the Doctor's Information Menu"
  puts "Press 'x' to exit"
  prompt
  main_menu_input = gets.chomp.downcase
  case main_menu_input
  when 'a'
    Doctor.all
    puts "\n"
    main_menu
  when 'b'
    doctor_menu
  when 'x'
    puts "Goodbye!"
  else
    puts "Invalid input"
    main_menu
  end
end

def doctor_menu
  puts "\n"
  puts "Doctor's Information:"
  puts "Press 'a' to add a Doctor"
  puts "Press 'u' to update a Doctor's information"
  puts "Press 'd' to delete a Doctor"
  puts "Press 'v' to view a Doctor's Specialty"
  puts "\n"
  puts "Patient Options:"
  puts "Press 'p' to enter the patient menu"
  puts "\n"
  puts "Menu Options:"
  puts "Press 'b' to go back to the Main Menu"
  puts "Press 'x' to exit"
  prompt
  doctor_choice = gets.chomp.downcase
  case doctor_choice
  when 'a'
    add_doctor
  when 'u'
    update_doctor
  when 'd'
    delete_doctor
  when 'p'
    patient_menu
  when 'v'
    view_specialty
  when 'b'
    main_menu
  when 'x'
    puts "Goodbye!"
  else
    puts "Invalid input"
    main_menu
  end
end

def add_doctor
  puts "\n"
  puts "Enter the name of the doctor that you would like to add"
  prompt
  doctor_name = gets.chomp
  DB.exec("INSERT INTO doctors (name) VALUES ('#{doctor_name}'); ")
  puts "Doctor Added!"
  puts "\n"
  puts "What is the doctors specialty area?"
  prompt
  specialty = gets.chomp
  doctors_id = DB.exec ("SELECT id FROM doctors WHERE name = '#{doctor_name}';")
  doctors_id.each do |result|
    @answer = result['id'].to_i
  end
  DB.exec("INSERT INTO specialty (type, doctors_id) VALUES ('#{specialty}', '#{@answer}'); ")
  puts "Specialty Added!"
  puts "\n"
  doctor_menu
end

def update_doctor
  puts "\n"
  puts "What doctor would you like to update the information for"
  puts "Enter 'n' to update the Doctor's name"
  puts "Enter 's' to update the Doctor's specialty"
  puts "Enter 'b' to go back to the Doctor's menu"
  prompt
  info_choice = gets.chomp.downcase
  case info_choice
  when 'n'
    new_name
  when 's'
    new_specialty
  when 'b'
    doctor_menu
  else
    "Invalid choice"
    main_menu
  end
end

def new_name
  puts "\n"
  puts "Enter the Doctor's name you'd like to update"
  prompt
  old_name = gets.chomp
  puts "Enter the Doctor's new name"
  prompt
  updated_name = gets.chomp
  DB.exec("UPDATE doctors SET name ='#{updated_name}' WHERE name = '#{old_name}';")
  puts "Name Updated!"
  puts "\n"
  update_doctor
end

def new_specialty
  puts "\n"
  puts "Enter the Doctor's name whose specialty you'd like to update"
  Doctor.all
  puts "\n"
  prompt
  doctor_choice = gets.chomp
  @answer = refactor(doctor_choice)
  puts "Enter the Doctor's new specialty"
  prompt
  updated_specialty = gets.chomp
  DB.exec("UPDATE specialty SET type ='#{updated_specialty}' WHERE doctors_id = '#{@answer}';")
  puts "Specialty Updated!"
  puts "\n"
  update_doctor
end

def delete_doctor
  puts "\n"
  puts "What doctor would you like to delete"
  Doctor.all
  puts "\n"
  prompt
  delete_choice = gets.chomp
  DB.exec("DELETE doctors WHERE name = '#{delete_choice}';")
  puts "Deleted!"
  puts "\n"
  doctor_menu
end

def view_specialty
  puts "\n"
  puts "Enter the Doctor's name whose specialty you'd like to view"
  Doctor.all
  puts "\n"
  prompt
  doctor_choice = gets.chomp
  @answer = refactor(doctor_choice)
  result = DB.exec("SELECT * FROM specialty WHERE doctors_id = '#{@answer}';")
  result.each do |x|
    puts "\n"
    puts "#{doctor_choice}'s specialty is:"
    puts x['type']
  end
  puts "\n"
  doctor_menu
end

def patient_menu
  puts "\n"
  puts "Press 'a' to add a patient to an existing doctor"
  puts "Press 'v' to view patients by Doctor name"
  puts "Press 'va' to view all patients"
  puts "Press 'b' to go back to the Doctors Menu"
  puts "Press 'x' to exit"
  prompt
  patient_choice = gets.chomp.downcase
  case patient_choice
  when 'a'
    add_patient
  when 'v'
    view_patients
  when 'va'
    puts "Here are all of our patients"
    Patient.all
    puts "\n"
    patient_menu
  when 'b'
    doctor_menu
  when 'x'
    puts "Goodbye!"
  else
    puts "Invalid input"
    main_menu
  end
end

def view_patients
  puts "\n"
  puts "Which doctor would you like to view patients for?"
  Doctor.all
  puts "\n"
  prompt
  doctor_choice = gets.chomp
  @answer = refactor(doctor_choice)
  result = DB.exec("SELECT * FROM patients WHERE doctors_id = '#{@answer}';")
  patients = []
  result.each do |x|
    patients << x['name']
  end
  puts "\n"
  puts "#{doctor_choice}'s patients are:"
  puts patients
  puts "\n"
  patient_menu
end

def add_patient
  puts "\n"
  puts "What doctor would you like to add a patient to?"
  Doctor.all
  puts "\n"
  prompt
  doctor_choice = gets.chomp
  @answer = refactor(doctor_choice)

  puts "Enter the patients name"
  prompt
  name = gets.chomp
  puts "Enter the patients birthday"
  prompt
  birthday = gets.chomp

  puts "Which of the following insurance companies does this patient use?"
  Insurance.all
  puts "\n"
  prompt
  insurance_choice = gets.chomp
  insurance_id = DB.exec ("SELECT id FROM insurance WHERE company = '#{insurance_choice}';")
  insurance_id.each do |result|
   @answer_id = result['id'].to_i
  end
  DB.exec("INSERT INTO patients (name, birthday, doctors_id, insurance_id) VALUES ('#{name}', '#{birthday}', '#{@answer}', '#{@answer_id}')")
  puts "Patient Added!"
  puts "\n"
  patient_menu
end

def refactor(doctor_choice)
  doctors_id = DB.exec ("SELECT id FROM doctors WHERE name = '#{doctor_choice}';")
  doctors_id.each do |result|
   @answer = result['id'].to_i
  end
  @answer
end

main_menu
