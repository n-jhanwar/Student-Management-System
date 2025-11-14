class Subject < ApplicationRecord
  belongs_to :instructor, optional: true
  has_many :enrollments, dependent: :destroy
  has_many :students, through: :enrollments

  validates :subject_code, presence: true, uniqueness: true
  validates :subject_name, presence: true
end
