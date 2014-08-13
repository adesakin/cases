class AddDocToUseCases < ActiveRecord::Migration
  def change
    add_column :use_cases, :doc, :string
  end
end
