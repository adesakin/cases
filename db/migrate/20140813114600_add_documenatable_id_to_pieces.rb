class AddDocumenatableIdToPieces < ActiveRecord::Migration
  def change
    add_column :pieces, :documentable_id, :integer
    add_column :pieces, :documentable_type, :string
  end
end
