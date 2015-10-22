module Bootsy
  class AttachmentUploader < CarrierWave::Uploader::Base
    include ActiveModel::Validations

    storage Bootsy.storage

    validate :size_limit

    def store_dir
      Bootsy.store_dir
    end

    private

    def size_limit
      return if Bootsy.file_size_limit.blank?
      return if file.size.to_f / (1000 * 1000) <= Bootsy.file_size_limit.to_f

      errors.add(:size, I18n.t(
                          'bootsy.errors.file_too_large',
                          limit: Bootsy.file_size_limit.to_f))
    end
  end
end
