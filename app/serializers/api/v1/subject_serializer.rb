class Api::V1::SubjectSerializer < ActiveModel::Serializer
  attributes :id, :subject_code, :subject_name, :semester, :instructor

  def instructor
    ::Api::V1::InstructorSerializer.new(object.instructor).as_json
  end
end