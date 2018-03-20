class School < ApplicationRecord
  has_and_belongs_to_many :groups
  has_many :candidates
  has_many :summaries, foreign_key: :school_id
  has_many :frequencies, foreign_key: :school_id
  has_many :exams, through: :summaries
  belongs_to :city
  has_one :state, through: :city

  def type
    dependency == 'private' ? :private : :public
  end
end
