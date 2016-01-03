module Bootsy
  class ImageUploader < CarrierWave::Uploader::Base
    include CarrierWave::MiniMagick
    include CarrierWave::MimeTypes

    storage Bootsy.storage

    def store_dir
      "#{Bootsy.store_dir}/#{model.class.to_s.underscore}/#{model.id}"
    end

    # process resize_to_limit: [1160, 2000]
    process :set_content_type
    process :save_content_type

    version :large, :if => :image? do
      process resize_to_fit: [
        Bootsy.large_image[:width], Bootsy.large_image[:height]
      ]
    end

    version :medium, :if => :image? do
      process resize_to_fit: [
        Bootsy.medium_image[:width], Bootsy.medium_image[:height]
      ]
    end

    version :small, :if => :image? do
      process resize_to_fit: [
        Bootsy.small_image[:width], Bootsy.small_image[:height]
      ]
    end

    version :thumb, :if => :image? do
      process resize_to_fill: [60, 60]
    end

    def extension_white_list
      %w(jpg jpeg gif png xls xlsx pdf csv doc docx)
    end

    protected
      def image?(new_file)
        new_file.content_type.start_with? 'image'
      end

      def save_content_type
        model.content_type = file.content_type if file.content_type
      end

  end
end
