module Bootsy
  class AttachmentsController < Bootsy.base_controller
    def create
      uploader = AttachmentUploader.new
      uploader.cache!(params[:attachment])

      if uploader.valid?
        uploader.store!
        render json: uploader.serializable_hash, status: :created
      else
        render json: uploader.errors, status: :unprocessable_entity
      end
    end
  end
end
