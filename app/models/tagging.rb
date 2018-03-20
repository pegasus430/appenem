class Tagging < ApplicationRecord
  belongs_to :question
  belongs_to :tag

  class << self
    primary = :question_id, :tag_id
  end
end
