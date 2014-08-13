class Piece < ActiveRecord::Base
  validates :doc, presence: true
  belongs_to :documentable, polymorphic: true

  mount_uploader :doc, DocUploader
end
