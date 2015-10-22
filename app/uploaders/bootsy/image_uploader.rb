module Bootsy
  class ImageUploader < AttachmentUploader
    include CarrierWave::MiniMagick

    storage Bootsy.storage

    process resize_to_limit: Bootsy.image_limit

    def extension_white_list
      %w(jpg jpeg gif png)
    end
  end
end
