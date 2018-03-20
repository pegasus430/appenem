class V1::OverviewComparisonSerializer < ActiveModel::Serializer
  has_one :school
  has_one :comparison_group
end
