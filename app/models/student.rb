class Student < ApplicationRecord
  has_many :enrollments
  has_many :subjects, through: :enrollments

  validates :first_name, :last_name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
  validates :contact, presence: true, length: { is: 10 }
  validates :date_of_birth, :date_of_admission, presence: true
  validate :validate_date_format

  enum :status, {
    active: 'active',
    inactive: 'inactive',
    graduated: 'graduated',
    suspended: 'suspended'
  }

  before_save :set_student_id

  private

  def set_student_id
    self.student_id = 'STU' + Date.today.year.to_s + '-' + SecureRandom.hex(4)

    while Student.exists?(student_id: self.student_id)
      self.student_id = 'STU' + Date.today.year.to_s + '-' + SecureRandom.hex(4)
    end
  end

  def validate_date_format
    if date_of_birth_before_type_cast.present? && !date_of_birth_before_type_cast.to_s.match?(/\A\d{2}-\d{2}-\d{4}\z/)
      errors.add(:date_of_birth, 'must be in dd-mm-yyyy format')
    end
    
    if date_of_admission_before_type_cast.present? && !date_of_admission_before_type_cast.to_s.match?(/\A\d{2}-\d{2}-\d{4}\z/)
      errors.add(:date_of_admission, 'must be in dd-mm-yyyy format')
    end
  end
end