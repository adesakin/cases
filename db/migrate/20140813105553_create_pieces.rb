class CreatePieces < ActiveRecord::Migration
  def change
    create_table :pieces do |t|
      t.string :name
      t.string :doc
      t.integer :modified_by_id
      t.integer :created_by_id

      t.timestamps
    end
  end
end
