class Api::V1::InstructorSerializer < ActiveModel::Serializer
  attributes :id, :instructor_id, :first_name, :last_name, :email, :contact, :formatted_hire_date, :status

  def formatted_hire_date
    object.hire_date.strftime('%d-%m-%Y')
  end
end