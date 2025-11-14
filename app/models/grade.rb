class Grade < ApplicationRecord
  belongs_to :enrollment

  validates :graded_date, presence: true
  validates :score, :max_score, :weight, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validate :score_cannot_exceed_max_score

  private

  def score_cannot_exceed_max_score
    if score.present? && max_score.present? && score > max_score
      errors.add(:score, "cannot be greater than the maximum score")
    end
  end
end
