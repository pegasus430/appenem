class OverviewComparison
  include ActiveModel::Serialization

  def initialize(school_relation, comparison_relation)
    @school_relation = school_relation
    @comparison_relation = comparison_relation
  end

  def school
    Overview.new(school_relation)
  end

  def comparison_group
    Overview.new(comparison_relation)
  end

  private

  attr_reader :school_relation, :comparison_relation
end
