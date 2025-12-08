require "test_helper"

class Api::V1::StudentsControllerTest < ActionDispatch::IntegrationTest

  def student_params(params = {})
    { student: create_student_params(params) }
  end

  test '#create, should create a student' do
    params = student_params

    assert_difference 'Student.count', 1 do
      post '/api/v1/students', params: params
    end

    assert_response :success

    assert_equal api_response['message'], 'Student created successfully'
    assert_equal api_response['student']['first_name'], params[:student][:first_name]
    assert_equal api_response['student']['last_name'], params[:student][:last_name]
    assert_equal api_response['student']['email'], params[:student][:email]
    assert_equal api_response['student']['contact'], params[:student][:contact].to_s
    assert_equal api_response['student']['formatted_date_of_birth'], params[:student][:date_of_birth]
    assert_equal api_response['student']['formatted_date_of_admission'], params[:student][:date_of_admission]
  end

  test '#create, should throw error for invalid date format' do
    params = student_params(date_of_birth: '2025-11-25', date_of_admission: '2025-11-25')

    assert_no_difference 'Student.count' do
      post '/api/v1/students', params: params
    end

    assert_response :unprocessable_entity

    assert_equal api_response['error'], ['Date of birth must be in dd-mm-yyyy format', 'Date of admission must be in dd-mm-yyyy format']
  end

  test '#show, should return details of a student' do
    student = create_student

    get "/api/v1/students/#{student.id}"

    assert_response :success

    assert_equal api_response['student']['id'], student.id
    assert_equal api_response['student']['first_name'], student.first_name
    assert_equal api_response['student']['last_name'], student.last_name
    assert_equal api_response['student']['email'], student.email
    assert_equal api_response['student']['contact'], student.contact.to_s
    assert_equal api_response['student']['formatted_date_of_birth'], student.date_of_birth.strftime('%d-%m-%Y')
    assert_equal api_response['student']['formatted_date_of_admission'], student.date_of_admission.strftime('%d-%m-%Y')
    assert_equal api_response['student']['status'], student.status
  end

  test '#update, should update first_name of a student' do
    student = create_student

    get "/api/v1/students/#{student.id}"

    assert_equal api_response['student']['id'], student.id
    assert_equal api_response['student']['first_name'], student.first_name
    assert_equal api_response['student']['formatted_date_of_birth'], student.date_of_birth.strftime('%d-%m-%Y')

    update_params = {
      first_name: Faker::Name.first_name,
      date_of_birth: Faker::Date.birthday.strftime('%d-%m-%Y')
    }

    put "/api/v1/students/#{student.id}", params: { student: update_params }

    assert_response :success

    assert_equal api_response['student']['id'], student.id
    assert_equal api_response['student']['first_name'], update_params[:first_name]
    assert_equal api_response['student']['formatted_date_of_birth'], update_params[:date_of_birth]
  end

  test '#update, should update last_name of a student' do
    student = create_student

    get "/api/v1/students/#{student.id}"
    assert_equal api_response['student']['id'], student.id
    assert_equal api_response['student']['last_name'], student.last_name

    update_params = {
      last_name: Faker::Name.last_name
    }

    put "/api/v1/students/#{student.id}", params: { student: update_params }

    assert_response :success

    assert_equal api_response['student']['id'], student.id
    assert_equal api_response['student']['last_name'], update_params[:last_name]
  end

  test '#update, should update date_of_birth of a student' do
    student = create_student

    get "/api/v1/students/#{student.id}"

    assert_equal api_response['student']['id'], student.id
    assert_equal api_response['student']['formatted_date_of_birth'], student.date_of_birth.strftime('%d-%m-%Y')

    update_params = {
      date_of_birth: Faker::Date.birthday.strftime('%d-%m-%Y')
    }

    put "/api/v1/students/#{student.id}", params: { student: update_params }

    assert_response :success

    assert_equal api_response['student']['id'], student.id
    assert_equal api_response['student']['formatted_date_of_birth'], update_params[:date_of_birth]
  end

  test '#update, should update date_of_admission of qa student' do
    student = create_student

    get "/api/v1/students/#{student.id}"

    assert_equal api_response['student']['id'], student.id
    assert_equal api_response['student']['formatted_date_of_admission'], student.date_of_admission.strftime('%d-%m-%Y')

    update_params = {
      date_of_admission: Faker::Date.between(from: 1.year.ago, to: Date.today).strftime('%d-%m-%Y')
    }

    put "/api/v1/students/#{student.id}", params: { student: update_params }

    assert_response :success

    assert_equal api_response['student']['id'], student.id
    assert_equal api_response['student']['formatted_date_of_admission'], update_params[:date_of_admission]
  end

  test '#update, should update email of a student' do
    student = create_student

    get "/api/v1/students/#{student.id}"
    assert_equal api_response['student']['id'], student.id
    assert_equal api_response['student']['email'], student.email

    update_params = {
      email: Faker::Internet.email
    }

    put "/api/v1/students/#{student.id}", params: { student: update_params }

    assert_response :success

    assert_equal api_response['student']['id'], student.id
    assert_equal api_response['student']['email'], update_params[:email]
  end

  test '#update, should update contact of a student' do
    student = create_student

    get "/api/v1/students/#{student.id}"
    assert_equal api_response['student']['id'], student.id
    assert_equal api_response['student']['contact'], student.contact.to_s

    update_params = {
      contact: Faker::Number.number(digits: 10)
    }

    put "/api/v1/students/#{student.id}", params: { student: update_params }

    assert_response :success

    assert_equal api_response['student']['id'], student.id
    assert_equal api_response['student']['contact'], update_params[:contact].to_s
  end

  test '#update, should not be able to update email if it is already taken' do
    student1 = create_student
    student2 = create_student

    update_params = {
      email: student1.email
    }

    put "/api/v1/students/#{student2.id}", params: { student: update_params }

    assert_response :unprocessable_entity

    assert_includes api_response['error'], 'Email has already been taken'
  end

  test '#update, should be able to update the status of a student' do
    student = create_student

    get "/api/v1/students/#{student.id}"
    assert_equal api_response['student']['id'], student.id
    assert_equal api_response['student']['status'], student.status

    update_params = {
      status: 'graduated'
    }

    put "/api/v1/students/#{student.id}", params: { student: update_params }

    assert_response :success

    assert_equal api_response['student']['id'], student.id
    assert_equal api_response['student']['status'], update_params[:status]
  end

  test '#update, should not be able to update student Id' do
    student = create_student
    original_student_id = student.student_id

    update_params = {
      student_id: 'STU2025-TEST1234'
    }

    put "/api/v1/students/#{student.id}", params: { student: update_params }

    assert_response :success
    student.reload

    assert_equal original_student_id, student.student_id
  end

  test '#show, should return not found if student does not exist' do
    get "/api/v1/students/0"

    assert_response :not_found

    assert_equal api_response['error'], 'Student does not exist'
  end

  test '#index, should return all students' do
    student1 = create_student
    student2 = create_student

    get "/api/v1/students"

    assert_response :success

    assert_equal api_response['students'].count, 2
  end

  test '#index, should return empty array if no students exist' do
    get "/api/v1/students"

    assert_response :success

    assert_empty api_response['students']
  end

  test '#destroy, should delete a student record' do
    student = create_student

    assert_difference 'Student.count', -1 do
      delete "/api/v1/students/#{student.id}"
    end

    assert_response :success

    assert_equal api_response['message'], 'Student deleted successfully'
  end

  test '#destroy, should return not found if student does not exist' do
    delete "/api/v1/students/0"

    assert_response :not_found

    assert_equal api_response['error'], 'Student does not exist'
  end
end
