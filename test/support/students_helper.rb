module StudentsHelper
  def create_student_params(overrides = {})
    {
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email,
      contact: Faker::Number.number(digits: 10),
      date_of_birth: Faker::Date.birthday.strftime('%d-%m-%Y'),
      date_of_admission: Faker::Date.between(from: 1.year.ago, to: Date.today).strftime('%d-%m-%Y')
    }.merge(overrides)
  end

  def create_student(overrides = {})
    Student.create(create_student_params(overrides))
  end
end