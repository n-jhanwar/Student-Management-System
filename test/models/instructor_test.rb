require "test_helper"

class InstructorTest < ActiveSupport::TestCase
  test 'should validate uniqueness of instructor_id' do
    instructor1 = create_instructor
    instructor2 = Instructor.new(create_instructor_params(instructor_id: instructor1.instructor_id))
    
    instructor2.define_singleton_method(:set_instructor_id) {} # Skip callback
    
    assert_not instructor2.valid?
    assert_includes instructor2.errors.full_messages, 'Instructor has already been taken'
  end

  test 'should validate presence of instructor_id' do
    instructor = Instructor.new(create_instructor_params(instructor_id: nil))
    instructor.define_singleton_method(:set_instructor_id) {}

    assert_not instructor.valid?
    assert_includes instructor.errors.full_messages, 'Instructor can\'t be blank'
  end

  test 'should validate presence of first_name' do
    instructor = Instructor.new(create_instructor_params(first_name: nil))
    
    assert_not instructor.valid?
    assert_includes instructor.errors.full_messages, 'First name can\'t be blank'
  end
  
  test 'should validate presence of last_name' do
    instructor = Instructor.new(create_instructor_params(last_name: nil))
    
    assert_not instructor.valid?
    assert_includes instructor.errors.full_messages, 'Last name can\'t be blank'
  end
  
  test 'should validate presence of email' do
    instructor = Instructor.new(create_instructor_params(email: nil))
    
    assert_not instructor.valid?
    assert_includes instructor.errors.full_messages, 'Email can\'t be blank'
  end

  test 'should validate presence of contact' do
    instructor = Instructor.new(create_instructor_params(contact: nil))
    
    assert_not instructor.valid?
    assert_includes instructor.errors.full_messages, 'Contact can\'t be blank'
  end

  test 'should validate presence of hire_date' do
    instructor = Instructor.new(create_instructor_params(hire_date: nil))
    
    assert_not instructor.valid?
    assert_includes instructor.errors.full_messages, 'Hire date can\'t be blank'
  end

  test 'should validate presence of status' do
    instructor = Instructor.new(create_instructor_params(status: nil))
    
    assert_not instructor.valid?
    assert_includes instructor.errors.full_messages, 'Status can\'t be blank'
  end

  test 'should validate date format of hire_date' do
    instructor = Instructor.new(create_instructor_params(hire_date: '2025-11-25'))
    
    assert_not instructor.valid?
    assert_includes instructor.errors.full_messages, 'Hire date must be in dd-mm-yyyy format'
  end

  test 'should validate email format' do
    instructor = Instructor.new(create_instructor_params(email: 'invalid-email'))
    
    assert_not instructor.valid?
    assert_includes instructor.errors.full_messages, 'Email is invalid'
  end

  test 'should validate contact format' do
    instructor = Instructor.new(create_instructor_params(contact: '12345678901'))
    
    assert_not instructor.valid?
    assert_includes instructor.errors.full_messages, 'Contact is the wrong length (should be 10 characters)'
  end
end
