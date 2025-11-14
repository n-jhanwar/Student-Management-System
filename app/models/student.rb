class Student < ApplicationRecord
  has_many :enrollments
  has_many :subjects, through: :enrollments

  enum status: {
    active: 'active',
    inactive: 'inactive',
    graduated: 'graduated',
    suspended: 'suspended'
  }
end