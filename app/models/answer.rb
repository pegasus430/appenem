class Answer < ApplicationRecord
  belongs_to :candidate
  belongs_to :alternative
end
