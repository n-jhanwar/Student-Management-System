module InstructorHelper
  def create_instructor_params(overrides = {})
    {
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email,
      contact: Faker::Number.number(digits: 10),
      hire_date: Faker::Date.between(from: 1.year.ago, to: Date.today).strftime('%d-%m-%Y')
    }.merge(overrides)
  end

  def create_instructor(overrides = {})
    Instructor.create(create_instructor_params(overrides))
  end
end