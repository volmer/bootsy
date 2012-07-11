# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  include Sprockets::Helpers::RailsHelper
  include Sprockets::Helpers::IsolatedHelper

  storage :file


  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{model.id}"
  end

  # Process files as they are uploaded:
  process :resize_to_limit => [940, 940]

  version :large do
    process :resize_to_fit => [600, 600]
  end

  version :medium do
    process :resize_to_fit => [300, 300]
  end

  version :small do
    process :resize_to_fit => [160, 160]
  end

  version :thumb do
    process :resize_to_fill => [60, 60]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end