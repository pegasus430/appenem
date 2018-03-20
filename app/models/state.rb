class State < ApplicationRecord
  has_many :cities
  has_many :schools, through: :cities
end
