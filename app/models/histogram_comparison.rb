class HistogramComparison
  include ActiveModel::Serialization

  def initialize(school_relation, comparison_relation)
    @school_relation = school_relation
    @comparison_relation = comparison_relation
  end

  def school
    histogram(school_relation)
  end

  def comparison_group
    histogram(comparison_relation)
  end

  private

  def histogram(relation)
    relation
      .select('COUNT(*) AS quantity, ROUND(scores.score / 25, 0) * 25 AS range_score')
      .group('range_score')
  end

  attr_reader :school_relation, :comparison_relation
end
