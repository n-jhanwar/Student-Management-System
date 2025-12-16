require "test_helper"

class SubjectTest < ActiveSupport::TestCase
  require 'test_helper'

  test 'should validate uniqueness of subject_code' do
    subject = create_subject
    subject2 = Subject.new(create_subject_params(subject_code: subject.subject_code))
    assert_not subject2.valid?
    assert_equal subject2.errors.full_messages, ['Subject code has already been taken']
  end

  test 'should validate presence of subject_code' do
    subject = Subject.new(create_subject_params(subject_code: nil))
    assert_not subject.valid?
    assert_equal subject.errors.full_messages, ['Subject code can\'t be blank']
  end

  test 'should allow subject creation without instructor' do
    subject = Subject.new(create_subject_params)
    assert subject.save
  end

  test 'should add error if instructor does not exist' do
    subject = Subject.new(create_subject_params(instructor_id: 0))
    assert_not subject.valid?
    assert_equal subject.errors.full_messages, ['Instructor does not exist']
  end

  test 'should validate presence of subject_name' do
    subject = Subject.new(create_subject_params(subject_name: nil))
    assert_not subject.valid?
    assert_equal subject.errors.full_messages, ['Subject name can\'t be blank']
  end

  test 'should validate presence of semester' do
    subject = Subject.new(create_subject_params(semester: nil))
    assert_not subject.valid?
    assert_equal subject.errors.full_messages, ['Semester can\'t be blank']
  end
end
