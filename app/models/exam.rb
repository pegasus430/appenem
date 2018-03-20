class Exam < ApplicationRecord
  has_many :candidates
  has_many :questions
  has_many :summaries, foreign_key: :exam_id
  has_many :schools, through: :summaries
  has_many :frequencies, foreign_key: :exam_id
end
