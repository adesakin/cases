class CreateSlices < ActiveRecord::Migration
  def change
    create_table :slices do |t|
      t.integer :use_case_id
      t.integer :priority
      t.string :workflow_state
      t.string :estimate
      t.integer :release_id
      t.integer :order_priority

      t.timestamps
    end
  end
end
