# encoding: utf-8
module Bootsy
  class ImageUploader < CarrierWave::Uploader::Base

    include CarrierWave::MiniMagick

    include Sprockets::Rails::Helper

    storage :file


    def store_dir
      "#{Bootsy.store_dir}/#{model.class.to_s.underscore}/#{model.id}"
    end

    # Process files as they are uploaded:
    process :resize_to_limit => [1160, 2000]

    version :large do
      process :resize_to_fit => [Bootsy.large_image[:width], Bootsy.large_image[:height]]
    end

    version :medium do
      process :resize_to_fit => [Bootsy.medium_image[:width], Bootsy.medium_image[:height]]
    end

    version :small do
      process :resize_to_fit => [Bootsy.small_image[:width], Bootsy.small_image[:height]]
    end

    version :thumb do
      process :resize_to_fill => [60, 60]
    end

    def extension_white_list
      %w(jpg jpeg gif png)
    end
  end
end