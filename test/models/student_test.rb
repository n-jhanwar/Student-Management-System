class StudentTest < ActiveSupport::TestCase
  require 'test_helper'

  test 'should set student_id before saving' do
    student = Student.new(create_student_params)

    student.save
    assert_not_nil student.student_id
  end

  test 'should validate date format' do
    student = Student.new(create_student_params(date_of_birth: '2025-11-25', date_of_admission: '2025-11-25'))

    assert_not student.valid?
    assert_equal student.errors.full_messages, ['Date of birth must be in dd-mm-yyyy format', 'Date of admission must be in dd-mm-yyyy format']
  end

  test 'should validate email format' do
    student = Student.new(create_student_params(email: 'invalid-email'))
    assert_not student.valid?
    assert_equal student.errors.full_messages, ['Email is invalid']
  end

  test 'should validate contact format' do
    student = Student.new(create_student_params(contact: '12345678901'))
    assert_not student.valid?
    assert_equal student.errors.full_messages, ['Contact is the wrong length (should be 10 characters)']
  end

  test 'should validate presence of first_name and last_name' do
    student = Student.new(create_student_params(first_name: nil, last_name: nil))
    assert_not student.valid?
    assert_equal student.errors.full_messages, ['First name can\'t be blank', 'Last name can\'t be blank']
  end

  test 'should validate presence of email' do
    student = Student.new(create_student_params(email: nil))
    assert_not student.valid?
    assert_includes student.errors.full_messages, 'Email can\'t be blank'
  end

  test 'should validate presence of contact' do
    student = Student.new(create_student_params(contact: nil))
    assert_not student.valid?
    assert_includes student.errors.full_messages, ['Contact can\'t be blank']
  end

  test 'should validate presence of date_of_birth and date_of_admission' do
    student = Student.new(create_student_params(date_of_birth: nil, date_of_admission: nil))
    assert_not student.valid?
    assert_equal student.errors.full_messages, ['Date of birth can\'t be blank', 'Date of admission can\'t be blank']
  end
end