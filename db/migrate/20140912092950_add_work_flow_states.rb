class AddWorkFlowStates < ActiveRecord::Migration
  def change

    add_column :use_cases, :workflow_state, :string
    add_column :projects, :workflow_state, :string
  end
end
