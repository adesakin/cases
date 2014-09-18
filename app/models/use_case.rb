class UseCase < ActiveRecord::Base
  belongs_to :project
  has_many :pieces, as: :documentable
  has_many :steps, dependent: :restrict_with_error
  accepts_nested_attributes_for :pieces, :reject_if => :all_blank, :allow_destroy => true
  accepts_nested_attributes_for :steps, :reject_if => :all_blank, :allow_destroy => true


  validates :project_id, :name, :description, :standard_flow, :presence => true
  after_commit :sync_project_time

  mount_uploader :doc, DocUploader

  include Workflow

  workflow do
    state :goal_established do
      event :done, :transitions_to => :structure_understood
    end
    state :structure_understood do
      event :done, :transitions_to => :simplest_fulfilled
      event :revert, :transitions_to => :goal_established
    end
    state :simplest_fulfilled do
      event :done, :transitions_to => :sufficient_fulfilled
      event :revert, :transitions_to => :structure_understood
    end
    state :sufficient_fulfilled do
      event :done, :transitions_to => :all_fulfilled
      event :revert, :transitions_to => :simplest_fulfilled
    end
    state :all_fulfilled do
      event :revert, :transitions_to => :sufficient_fulfilled
    end
  end

  def slices
    steps = Arel::Table.new(:steps)
    Slice.joins(:steps).where(steps[:use_case_id].eq(self.id))
  end

  private

  def sync_project_time
  	project.touch
  end

end
