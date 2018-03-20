class Skill < ApplicationRecord
  belongs_to :area
  has_many :questions
end
