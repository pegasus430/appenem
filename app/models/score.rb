class Score < ApplicationRecord
  belongs_to :area
  belongs_to :candidate
end
