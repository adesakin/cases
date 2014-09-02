class CreateSteps < ActiveRecord::Migration
  def change
    create_table :steps do |t|
      t.string :custom_id
      t.string :state
      t.text :description

      t.timestamps
    end
  end
end
