class Candidate < ApplicationRecord
  belongs_to :exam
  belongs_to :school, optional: true
  belongs_to :cities, optional: true
  has_many :scores
  has_many :answers

  scope :valid, -> { where(candidates_query) }

  class << self
    private

    CONSISTENT_YEARS = [7, 6, 5, 3].join(',')
    IRREGULAR_YEARS = [1, 2, 4].join(',')
    REGULAR_YEARS = [8].join(',')

    def candidates_query
      <<~SQL
        IF(
          #{consistent_years},
          #{consistent},
          IF(
            #{regular_years},
            #{regular},
            #{irregular}
          )
        )
      SQL
    end

    def context(years)
      "#{table_name}.exam_id IN (#{years})"
    end

    def consistent_years
      context(CONSISTENT_YEARS)
    end

    def irregular_years
      context(IRREGULAR_YEARS)
    end

    def regular_years
      context(REGULAR_YEARS)
    end

    def consistent
      "#{table_name}.consistency IN ('validated', 'overwritten')"
    end

    def irregular
      "#{table_name}.conclusion = 'current'"
    end

    def regular
      <<~SQL
        #{table_name}.conclusion = 'current'
        AND #{table_name}.conclusion_type IN ('regular', 'professional')
      SQL
    end
  end
end
