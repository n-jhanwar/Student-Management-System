class Instructor < ApplicationRecord
   has_many :subjects, dependent: :nullify

  validates :instructor_id, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :first_name, :last_name, :hire_date, :status, presence: true

  enum status: {
    active: 'active',
    inactive: 'inactive'
  }
end
