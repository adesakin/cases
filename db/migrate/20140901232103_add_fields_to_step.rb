class AddFieldsToStep < ActiveRecord::Migration
  def change
    add_column :steps, :use_case_id, :integer
    add_column :steps, :type, :string
  end
end
