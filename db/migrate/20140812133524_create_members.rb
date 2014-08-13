class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :first_name
      t.string :last_name
      t.belongs_to :user, index: true
      t.string :title
      t.text :note

      t.timestamps
    end
  end
end
