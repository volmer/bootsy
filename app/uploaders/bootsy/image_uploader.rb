module Bootsy
  class ImageUploader < CarrierWave::Uploader::Base
    include CarrierWave::MiniMagick

    storage Bootsy.storage

    def store_dir
      Bootsy.store_dir
    end

    process resize_to_limit: Bootsy.image_limit

    def extension_white_list
      %w(jpg jpeg gif png)
    end
  end
end
