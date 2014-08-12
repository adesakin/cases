class UseCase < ActiveRecord::Base
  belongs_to :project
  validates :project_id, :name, :description, :standard_flow, :presence => true

  after_commit :sync_project_time


  private

  def sync_project_time
  	project.touch
  end
end
