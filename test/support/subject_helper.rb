module SubjectHelper
  def create_subject_params(overrides = {})
    params = {
      subject_code: Faker::Alphanumeric.alphanumeric(number: 10),
      subject_name: Faker::Lorem.word,
      semester: Faker::Number.between(from: 1, to: 8).to_s
    }

    params[:instructor_id] = overrides[:instructor_id] if overrides.key?(:instructor_id)
    params.merge(overrides)
  end

  def create_subject(overrides = {})
    Subject.create(create_subject_params(overrides))
  end
end