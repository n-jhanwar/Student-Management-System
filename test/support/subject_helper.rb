module SubjectHelper
  def create_subject_params(overrides = {})
    {
      subject_code: Faker::Alphanumeric.alphanumeric(number: 10),
      subject_name: Faker::Lorem.word,
      instructor_id: create_instructor.id,
    }.merge(overrides)
  end

  def create_subject(overrides = {})
    Subject.create(create_subject_params(overrides))
  end
end