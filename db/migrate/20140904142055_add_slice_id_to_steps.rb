class AddSliceIdToSteps < ActiveRecord::Migration
  def change
    add_column :steps, :slice_id, :integer
    add_column :slices, :project_id, :integer
  end
end
