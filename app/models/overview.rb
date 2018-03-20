class Overview
  include ActiveModel::Serialization

  def initialize(relation)
    @relation = relation
  end

  def avg_score
    relation.average(:score)&.round(1) || 0
  end

  def min_score
    relation.minimum(:score)&.round(1) || 0
  end

  def max_score
    relation.maximum(:score)&.round(1) || 0
  end

  private

  attr_reader :relation
end
