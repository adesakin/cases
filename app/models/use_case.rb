class UseCase < ActiveRecord::Base
  belongs_to :project
  has_many :pieces, as: :documentable
  accepts_nested_attributes_for :pieces, :reject_if => :all_blank, :allow_destroy => true

  validates :project_id, :name, :description, :standard_flow, :presence => true
  after_commit :sync_project_time

  mount_uploader :doc, DocUploader


  private

  def sync_project_time
  	project.touch
  end
end
