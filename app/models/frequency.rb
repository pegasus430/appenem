class Frequency < ApplicationRecord
  belongs_to :school
  belongs_to :exam
  belongs_to :question
  belongs_to :alternative

  class << self
    primary_keys = :school_id, :exam_id, :question_id, :alternative_id
  end
end
