class V1::OverviewSerializer < ActiveModel::Serializer
  attributes :avg_score, :min_score, :max_score
end
