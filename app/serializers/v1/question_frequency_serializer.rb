class V1::QuestionFrequencySerializer < ActiveModel::Serializer
  attributes :id,
             :position,
             :label,
             :skill,
             :subject,
             :tags,
             :own_correct_answers,
             :own_answers,
             :comparison_correct_answers,
             :comparison_answers
end
