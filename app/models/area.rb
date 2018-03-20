class Area < ApplicationRecord
  has_many :skills
  has_many :subjects
  has_many :scores
end
