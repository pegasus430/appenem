class Summary < ApplicationRecord
  belongs_to :school
  belongs_to :exam

  class << self
    primary_keys = :exam_id, :school_id
  end
end
