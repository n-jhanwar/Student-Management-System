class Student < ApplicationRecord
  has_many :enrollments
  has_many :subjects, through: :enrollments

  before_validation :set_student_id, on: :create

  validates :student_id, presence: true, uniqueness: true
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

  private

  def set_student_id
    self.student_id = get_student_id

    while Student.exists?(student_id: self.student_id)
      self.student_id = get_student_id
    end
  end

  def validate_date_format
    if date_of_birth_before_type_cast.present? && (new_record? || date_of_birth_changed?)
      unless date_of_birth_before_type_cast.to_s.match?(/\A\d{2}-\d{2}-\d{4}\z/)
        errors.add(:date_of_birth, 'must be in dd-mm-yyyy format')
      end
    end
    
    if date_of_admission_before_type_cast.present? && (new_record? || date_of_admission_changed?)
      unless date_of_admission_before_type_cast.to_s.match?(/\A\d{2}-\d{2}-\d{4}\z/)
        errors.add(:date_of_admission, 'must be in dd-mm-yyyy format')
      end
    end
  end

  def get_student_id
    'STU' + Date.today.year.to_s + '-' + SecureRandom.hex(4)
  end
end