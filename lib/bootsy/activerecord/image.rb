module Bootsy
  # Public: Model to reference the actual image stored trough Bootsy.
  # It contains the CarrierWave uploader and belongs to a
  # particular image gallery.
  class Image < ActiveRecord::Base
    belongs_to :image_gallery, touch: true

    mount_uploader :image_file, ImageUploader

    validates_presence_of :image_file, :image_gallery_id
  end
end
