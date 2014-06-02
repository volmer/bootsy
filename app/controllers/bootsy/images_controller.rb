require_dependency 'bootsy/application_controller'

module Bootsy
  class ImagesController < Bootsy::ApplicationController
    def index
      @gallery = find_gallery
      @images = @gallery.images

      respond_to do |format|
        format.html # index.html.erb

        format.json do
          render json: {
            images: @images.map {|image| image_markup(image) },
            form: new_image_markup(@gallery)
          }
        end
      end
    end

    def create
      @gallery = find_gallery
      @gallery.save! unless @gallery.persisted?
      @image = @gallery.images.new(image_params)

      respond_to do |format|
        if @image.save
          format.json {
            render json: {
              image: image_markup(@image),
              form: new_image_markup(@gallery),
              gallery_id: @gallery.id
            }
          }
        else
          format.json {
            render json: @image.errors,
            status: :unprocessable_entity
          }
        end
      end
    end

    def destroy
      @image = Image.find(params[:id])
      @image.destroy

      respond_to do |format|
        format.json {
          render json: { id: params[:id] }
        }

        format.html { redirect_to images_url }
      end
    end

    private

    def find_gallery
      ImageGallery.find(params[:image_gallery_id])
    end

    # Private: Returns the String markup to render
    # an image in the gallery modal.
    #
    # image - The `Bootsy::Image` instance that will
    #         be rendered.
    def image_markup(image)
      render_to_string(
        file: 'bootsy/images/_image',
        formats: [:html],
        locals: { image: image }
      )
    end

    # Private: Returns the String markup to render
    # a form to upload a new image in a given gallery.
    #
    # gallery - The `Bootsy::ImageGallery` instance which
    #           the image will be uploaded to.
    def new_image_markup(gallery)
      render_to_string(
        file: 'bootsy/images/_new',
        formats: [:html],
        locals: { gallery: gallery, image: gallery.images.new }
      )
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_params
      params.require(:image).permit(:image_file)
    end
  end
end
