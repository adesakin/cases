class CreateUseCases < ActiveRecord::Migration
  def change
    create_table :use_cases do |t|
      t.string :name
      t.text :description
      t.text :pre_condition
      t.text :standard_flow
      t.text :alternate_flow
      t.text :post_condition
      t.text :open_issue
      t.string :state

      t.timestamps
    end
  end
end
