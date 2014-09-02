class UseCase < ActiveRecord::Base
  belongs_to :project
  has_many :pieces, as: :documentable
  has_many :steps, dependent: :restrict_with_error
  accepts_nested_attributes_for :pieces, :reject_if => :all_blank, :allow_destroy => true
  accepts_nested_attributes_for :steps, :reject_if => :all_blank, :allow_destroy => true


  validates :project_id, :name, :description, :standard_flow, :presence => true
  after_commit :sync_project_time

  mount_uploader :doc, DocUploader


  private

  def sync_project_time
  	project.touch
  end
end
