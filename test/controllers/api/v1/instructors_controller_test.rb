require "test_helper"

class Api::V1::InstructorsControllerTest < ActionDispatch::IntegrationTest
  def instructor_params(params = {})
    { instructor: create_instructor_params(params) }
  end

  test '#create, should create an instructor' do
    params = instructor_params

    assert_difference 'Instructor.count', 1 do
      post '/api/v1/instructors', params: params
    end

    assert_response :success

    assert_equal api_response['message'], 'Instructor created successfully'
    assert_equal api_response['instructor']['first_name'], params[:instructor][:first_name]
    assert_equal api_response['instructor']['last_name'], params[:instructor][:last_name]
    assert_equal api_response['instructor']['email'], params[:instructor][:email]
    assert_equal api_response['instructor']['contact'], params[:instructor][:contact].to_s
    assert_equal api_response['instructor']['formatted_hire_date'], params[:instructor][:hire_date]
  end

  test '#create, should not create an instructor with invalid date format' do
    params = instructor_params(hire_date: '2025-11-25')

    assert_no_difference 'Instructor.count' do
      post '/api/v1/instructors', params: params
    end

    assert_response :unprocessable_entity
    assert_includes api_response['error'], 'Hire date must be in dd-mm-yyyy format'
  end

  test '#create, should not create an instructor with invalid email format' do
    params = instructor_params(email: 'invalid-email')

    assert_no_difference 'Instructor.count' do
      post '/api/v1/instructors', params: params
    end

    assert_response :unprocessable_entity
    assert_includes api_response['error'], 'Email is invalid'
  end

  test '#create, should not create an instructor with invalid contact format' do
    params = instructor_params(contact: '12345678901')

    assert_no_difference 'Instructor.count' do
      post '/api/v1/instructors', params: params
    end

    assert_response :unprocessable_entity
    assert_includes api_response['error'], 'Contact is the wrong length (should be 10 characters)'
  end

  test '#show, should show an instructor' do
    instructor = create_instructor

    get "/api/v1/instructors/#{instructor.id}"
    assert_response :success

    assert_equal api_response['instructor']['id'], instructor.id
  end

  test '#show, should return an error if the instructor that does not exist' do
    get "/api/v1/instructors/0"
    assert_response :not_found

    assert_includes api_response['error'], 'Instructor does not exist'
  end

  test '#index, should return all instructors' do
    instructor1 = create_instructor
    instructor2 = create_instructor

    get "/api/v1/instructors"
    assert_response :success

    assert_equal api_response['instructors'].count, 2
    assert_equal api_response['instructors'][0]['id'], instructor1.id
    assert_equal api_response['instructors'][1]['id'], instructor2.id
  end

  test '#index, should return empty array if no instructors exist' do
    get "/api/v1/instructors"
    assert_response :success

    assert_empty api_response['instructors']
  end
  
  test '#update, should update an instructor' do
    instructor = create_instructor

    put "/api/v1/instructors/#{instructor.id}", params: instructor_params(first_name: 'John')
    assert_response :success

    assert_equal api_response['message'], 'Instructor updated successfully'
    assert_equal api_response['instructor']['first_name'], 'John'
  end

  test '#update, should not update an instructor with invalid date format' do
    instructor = create_instructor

    put "/api/v1/instructors/#{instructor.id}", params: instructor_params(hire_date: '2025-11-25')
    assert_response :unprocessable_entity
    assert_includes api_response['error'], 'Hire date must be in dd-mm-yyyy format'
  end

  test '#update, should not update an instructor with invalid email format' do
    instructor = create_instructor

    put "/api/v1/instructors/#{instructor.id}", params: instructor_params(email: 'invalid-email')
    assert_response :unprocessable_entity
    assert_includes api_response['error'], 'Email is invalid'
  end

  test '#update, should not update an instructor with invalid contact format' do
    instructor = create_instructor

    put "/api/v1/instructors/#{instructor.id}", params: instructor_params(contact: '12345678901')
    assert_response :unprocessable_entity
    assert_includes api_response['error'], 'Contact is the wrong length (should be 10 characters)'
  end

  test '#update, should update status of an instructor' do
    instructor = create_instructor

    put "/api/v1/instructors/#{instructor.id}", params: instructor_params(status: 'inactive')
    assert_response :success
    assert_equal api_response['message'], 'Instructor updated successfully'
    assert_equal api_response['instructor']['status'], 'inactive'
  end

  test '#update, should not update an instructor if it does not exist' do
    put "/api/v1/instructors/0", params: instructor_params(first_name: 'John')
    assert_response :not_found
    assert_includes api_response['error'], 'Instructor does not exist'
  end

  test '#destroy, should delete an instructor' do
    instructor = create_instructor

    assert_difference 'Instructor.count', -1 do
      delete "/api/v1/instructors/#{instructor.id}"
    end
  end

  test '#destroy, should not delete an instructor if it does not exist' do
    delete "/api/v1/instructors/0"
    assert_response :not_found
    assert_includes api_response['error'], 'Instructor does not exist'
  end
end
