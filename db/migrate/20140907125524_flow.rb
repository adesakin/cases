class Flow < ActiveRecord::Migration
  def change
    create_table :flows do |t|
      t.belongs_to :step
      t.belongs_to :slice
      t.integer :sort_order
      t.string :priority

      t.timestamps
    end
  end
end
