class Subject < ApplicationRecord
  belongs_to :instructor, optional: true
  has_many :enrollments, dependent: :destroy
  has_many :students, through: :enrollments

  validates :subject_code, presence: true, uniqueness: true
  validates :subject_name, :semester, presence: true
  validate :instructor_exists, if: -> { instructor_id.present? }

  private

  def instructor_exists
    unless Instructor.exists?(id: instructor_id)
      errors.add(:instructor_id, 'does not exist')
    end
  end
end
