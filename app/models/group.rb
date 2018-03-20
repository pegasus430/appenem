class Group < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :schools

  validates_presence_of :schools
end
