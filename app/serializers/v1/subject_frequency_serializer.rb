class V1::SubjectFrequencySerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :own_correct_answers,
             :own_answers,
             :comparison_correct_answers,
             :comparison_answers
end
