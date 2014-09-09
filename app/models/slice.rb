class Slice < ActiveRecord::Base
  belongs_to :project
  has_many :steps
  has_many :flows
  has_many :steps, through: :flows
  accepts_nested_attributes_for :flows
end
