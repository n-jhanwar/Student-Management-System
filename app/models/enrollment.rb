class Enrollment < ApplicationRecord
  belongs_to :student
  belongs_to :subject

  has_many :attendances, dependent: :destroy
  has_many :grades, dependent: :destroy

  validates :student_id, uniqueness: { scope: :subject_id, message: 'is already enrolled in this subject' }
  validates :enrollment_date, :status, presence: true

  enum :status, {
    enrolled: 'enrolled',
    completed: 'completed',
    dropped: 'dropped',
  }
end
