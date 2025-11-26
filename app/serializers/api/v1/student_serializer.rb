class Api::V1::StudentSerializer < ActiveModel::Serializer
  attributes :id, :student_id, :first_name, :last_name, :email, :contact, :formatted_date_of_birth, :formatted_date_of_admission, :status

  def formatted_date_of_birth
    object.date_of_birth.strftime('%d-%m-%Y')
  end

  def formatted_date_of_admission
    object.date_of_admission.strftime('%d-%m-%Y')
  end
end
