class V1::SkillFrequencySerializer < ActiveModel::Serializer
  attributes :id,
             :label,
             :description,
             :own_correct_answers,
             :own_answers,
             :comparison_correct_answers,
             :comparison_answers
end
