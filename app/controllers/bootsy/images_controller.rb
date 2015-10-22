module Bootsy
  class ImagesController < Bootsy.base_controller
    def create
      uploader = ImageUploader.new
      uploader.store!(params[:image])
      image = { url: uploader.url }
      render json: image, status: :created
    end
  end
end
