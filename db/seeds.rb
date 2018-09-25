# frozen_string_literal: true

# The aim of this setup is to simulate the most diversified combination of doctors availability.
# Should be used for unit testing and staging dummy data.
require 'faker'

schools_amount = 30
names = %q(
  Yuliana Bailey, Colton Jackson, Jair Barrera, Anabel Cooley, Victor Robles, Terrell Mcpherson, Mylie Doyle, Eve Bray,
  Miya Kelly, Aaron Hunter, Julie Shepard, Fernando Mora, Kareem Rios, Tanya Shaffer, Adeline Kane, Karma Cordova,
  Salvador Roach, Maddison Cuevas, Braxton Jordan, Nola Morris, Shirley Shea, Aniya Ellis, Callie Valencia,
  Lorenzo Frank, Penelope Shaw, Stephanie Norman, Baylee Mckee, Kaleigh Washington, Makayla Schroeder, Audrina Colon
).squish.split(', ')

unless Rails.env.production?
  puts 'Creating seeds...'

  students_data = 3.times.map do |student_id|
    {
      email: "demostudent#{student_id}@test.com",
      password: 'p@ssword',
      role: :student,
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      is_active: true,
      confirmed_at: Time.current - 2.days,
      profile_attributes: {
        gender: 'm',
        # address: 'MyString',
        phone: Faker::PhoneNumber.cell_phone,
        age: "2#{student_id}"
      }
    }
  end

  students_data << [{
    email: 'incompletestudent@example.com',
    password: 'p@ssword',
    role: :student,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    confirmed_at: Time.current - 2.days,
  }, {
    email: 'unconfirmedstudent@example.com',
    password: 'p@ssword',
    role: :student,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name
  }]

  User.create!(students_data)

  schools_data = schools_amount.times.map do |school_id|
    first_name, last_name = names[school_id].split(' ')
    company_name = Faker::Company.name

    school = {
      email: "demoschool#{school_id}@example.com",
      password: 'p@ssword',
      role: :school,
      first_name: "#{first_name} {demo}",
      last_name: last_name,
      is_active: true,
      confirmed_at: Time.current - 2.days,
      profile_attributes: {
        name: company_name,
        phone: Faker::PhoneNumber.cell_phone,
        website: "https://#{company_name}.com",
        description: Faker::Lorem.paragraph
      }
    }

    school
  end

  schools_data << [{
    email: 'incomplete@example.com',
    password: 'p@ssword',
    role: :school,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    confirmed_at: Time.current - 2.days,
    is_active: true
  }, {
    email: 'unconfirmedschool@example.com',
    password: 'p@ssword',
    role: :student,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name
  }]

  User.create!(schools_data)

  puts 'Seeds created.'
end
