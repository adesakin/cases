class AddProjectIdToUseCases < ActiveRecord::Migration
  def change
    add_column :use_cases, :project_id, :integer
  end
end
