# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  include Sprockets::Helpers::RailsHelper
  include Sprockets::Helpers::IsolatedHelper

  storage :file


  def store_dir
    "bootsy_uploads/#{model.class.to_s.underscore}/#{model.id}/#{mounted_as}"
  end

  # Process files as they are uploaded:
  process :resize_to_fit => [800, 800]
  process :convert => 'png'

  version :full do
    process :resize_to_fill => [600, 600]
    process :convert => 'png'
  end

  version :medium do
    process :resize_to_fill => [300, 300]
    process :convert => 'png'
  end

  version :small do
    process :resize_to_fill => [160, 160]
    process :convert => 'png'
  end

  version :thumb do
    process :resize_to_fill => [60, 60]
    process :convert => 'png'
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def filename
    @name ||= "#{md5}.png" if original_filename.present?
  end

  protected
  def md5
    @md5 ||= Digest::MD5.hexdigest(model.image_file.read)
  end

end