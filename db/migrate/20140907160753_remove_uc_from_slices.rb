class RemoveUcFromSlices < ActiveRecord::Migration
  def change
    remove_column :slices, :use_case_id, :integer
    remove_column :steps, :slice_id, :integer
  end
end
