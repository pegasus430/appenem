class Alternative < ApplicationRecord
  belongs_to :question
  has_many :answers
  has_many :frequencies, foreign_key: :alternative_id

  scope :with_frequency, ->(school_id) do
    fields = 'alternatives.*, SUM(frequencies.frequency) AS frequency'
    frequencies =
      'LEFT JOIN frequencies ON frequencies.alternative_id = alternatives.id'
    select(fields)
      .joins(frequencies)
      .where(frequencies: { school_id: school_id })
      .group(:id)
  end
end
