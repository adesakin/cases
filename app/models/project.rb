class Project < ActiveRecord::Base
  has_many :use_cases, dependent: :restrict_with_error
  accepts_nested_attributes_for :use_cases, :reject_if => :all_blank, :allow_destroy => true

  validates :name, :presence => true
  validates :name, :uniqueness => true

end
