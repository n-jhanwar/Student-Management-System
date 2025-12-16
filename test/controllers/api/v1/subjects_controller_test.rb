require "test_helper"

class Api::V1::SubjectsControllerTest < ActionDispatch::IntegrationTest
  def subject_params(params = {})
    { subject: create_subject_params(params) }
  end

  test '#create, should create a subject without instructor' do
    params = subject_params

    assert_difference 'Subject.count', 1 do
      post '/api/v1/subjects', params: params
    end

    assert_response :success

    assert_equal api_response['message'], 'Subject created successfully'
    assert_equal api_response['subject']['subject_code'], params[:subject][:subject_code]
    assert_equal api_response['subject']['subject_name'], params[:subject][:subject_name]
    assert_equal api_response['subject']['semester'], params[:subject][:semester]
  end

  test '#create, should create a subject with instructor' do
    params = subject_params(instructor_id: create_instructor.id)

    assert_difference 'Subject.count', 1 do
      post '/api/v1/subjects', params: params
    end

    assert_response :success

    assert_equal api_response['message'], 'Subject created successfully'
    assert_equal api_response['subject']['subject_code'], params[:subject][:subject_code]
    assert_equal api_response['subject']['subject_name'], params[:subject][:subject_name]
    assert_equal api_response['subject']['semester'], params[:subject][:semester]
    assert_equal api_response['subject']['instructor']['id'], params[:subject][:instructor_id]
  end

  test '#create, should not create a subject with invalid instructor id' do
    params = subject_params(instructor_id: 0)

    assert_no_difference 'Subject.count' do
      post '/api/v1/subjects', params: params
    end

    assert_response :unprocessable_entity
    assert_includes api_response['error'], 'Instructor does not exist'
  end

  test '#show, should show a subject' do
    subject = create_subject(instructor_id: create_instructor.id)

    get "/api/v1/subjects/#{subject.id}"
    assert_response :success

    assert_equal api_response['subject']['id'], subject.id
    assert_equal api_response['subject']['subject_code'], subject.subject_code
    assert_equal api_response['subject']['subject_name'], subject.subject_name
    assert_equal api_response['subject']['semester'], subject.semester
    assert_equal api_response['subject']['instructor']['id'], subject.instructor.id
  end

  test '#show, should return an error if the subject that does not exist' do
    get "/api/v1/subjects/0"
    assert_response :not_found

    assert_includes api_response['error'], 'Subject does not exist'
  end

  test '#index, should return all subjects' do
    subject1 = create_subject(instructor_id: create_instructor.id)
    subject2 = create_subject(instructor_id: create_instructor.id)

    get "/api/v1/subjects"
    assert_response :success

    assert_equal api_response['subjects'].count, 2
    assert_equal api_response['subjects'][0]['id'], subject1.id
    assert_equal api_response['subjects'][1]['id'], subject2.id
  end

  test '#index, should return empty array if no subjects exist' do
    get "/api/v1/subjects"
    assert_response :success

    assert_empty api_response['subjects']
  end

  test '#destroy, should delete a subject' do
    subject = create_subject(instructor_id: create_instructor.id)

    assert_difference 'Subject.count', -1 do
      delete "/api/v1/subjects/#{subject.id}"
    end

    assert_response :success
    assert_equal api_response['message'], 'Subject deleted successfully'
  end

  test '#destroy, should return an error if the subject that does not exist' do
    delete "/api/v1/subjects/0"

    assert_response :not_found
    assert_includes api_response['error'], 'Subject does not exist'
  end

  test '#update, should update a subject' do
    subject = create_subject(instructor_id: create_instructor.id)

    put "/api/v1/subjects/#{subject.id}", params: { subject: { subject_name: 'New Subject Name' } }
    assert_response :success
    assert_equal api_response['message'], 'Subject updated successfully'
    assert_equal api_response['subject']['subject_name'], 'New Subject Name'
  end

  test '#update, should return an error if the subject that does not exist' do
    put "/api/v1/subjects/0", params: { subject: { subject_name: 'New Subject Name' } }
    assert_response :not_found
    assert_includes api_response['error'], 'Subject does not exist'
  end

  test '#update, should return an error if the subject code is already taken' do
    subject1 = create_subject(instructor_id: create_instructor.id)
    subject2 = create_subject(instructor_id: create_instructor.id)

    put "/api/v1/subjects/#{subject1.id}", params: { subject: { subject_code: subject2.subject_code } }
  
    assert_response :unprocessable_entity
    assert_includes api_response['error'], 'Subject code has already been taken'
  end
end