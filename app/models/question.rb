class Question < ApplicationRecord
  belongs_to :skill
  belongs_to :subject
  belongs_to :exams
  has_many :taggings, foreign_key: :question_id
  has_many :tags, through: :taggings
  has_many :alternatives
  has_many :frequencies, foreign_key: :question_id
end
