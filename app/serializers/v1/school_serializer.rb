class V1::SchoolSerializer < ActiveModel::Serializer
  attributes :id, :name, :inep_code, :type, :exams
end
