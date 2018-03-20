class V1::SchoolWithExamsSerializer < ActiveModel::Serializer
  attributes :id, :name, :inep_code, :exams
end
