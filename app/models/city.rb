class City < ApplicationRecord
  belongs_to :state
  has_many :candidates
  has_many :schools
end
