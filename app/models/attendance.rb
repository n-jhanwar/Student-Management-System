class Attendance < ApplicationRecord
  belongs_to :enrollment

  validates :attendance_date, presence: true, uniqueness: { scope: :enrollment_id }
  validates :status, presence: :true
  enum status: {
    present: 'present',
    absent: 'absent',
    late: 'late'
  }
end
