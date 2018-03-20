class Tag < ApplicationRecord
  has_many :taggings, foreign_key: :tag_id
  has_many :questions, through: :taggings
end
