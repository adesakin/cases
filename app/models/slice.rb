class Slice < ActiveRecord::Base
  belongs_to :project
  has_many :flows
  has_many :steps, through: :flows
  accepts_nested_attributes_for :flows, :reject_if => :all_blank, :allow_destroy => true
  #validate :has_steps

  include Workflow

  workflow do
    state :scoped do
      event :done, :transitions_to => :prepared
    end
    state :prepared do
      event :done, :transitions_to => :analyzed
      event :revert, :transitions_to => :scoped
    end
    state :analyzed do
      event :done, :transitions_to => :implemented
      event :revert, :transitions_to => :prepared
    end
    state :implemented do
      event :done, :transitions_to => :verified
      event :revert, :transitions_to => :analyzed
    end
    state :verified do
      event :revert, :transitions_to => :implemented
    end
  end

  def has_steps
    if steps.empty? or steps.all? {|step| step.marked_for_destruction? }
      errors.add(:base, 'Must have at least one step')
    end
  end

end
