class V1::QuestionDetailSerializer < ActiveModel::Serializer
  attributes :id, :position, :label, :content, :skill, :subject, :tags,
             :alternatives
end
