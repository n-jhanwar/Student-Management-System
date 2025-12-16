class Instructor < ApplicationRecord
  has_many :subjects, dependent: :nullify

  before_validation :set_instructor_id, on: :create

  validates :instructor_id, presence: true, uniqueness: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
  validates :first_name, :last_name, :hire_date, :status, presence: true
  validates :contact, presence: true, length: { is: 10 }
  validate :validate_hire_date_format

  enum :status, {
    active: 'active',
    inactive: 'inactive'
  }

  private

  def validate_hire_date_format
    if hire_date_before_type_cast.present? && (new_record? || hire_date_changed?)
      unless hire_date_before_type_cast.to_s.match?(/\A\d{2}-\d{2}-\d{4}\z/)
        errors.add(:hire_date, 'must be in dd-mm-yyyy format')
      end
    end
  end

  def set_instructor_id
    self.instructor_id = get_instructor_id

    while Instructor.exists?(instructor_id: self.instructor_id)
      self.instructor_id = get_instructor_id
    end
  end

  def get_instructor_id
    'INS' + Date.today.year.to_s + '-' + SecureRandom.hex(4)
  end
end
