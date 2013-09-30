require_dependency "bootsy/application_controller"

module Bootsy
  class ImagesController < Bootsy::ApplicationController
    # GET /images
    # GET /images.json
    def index
      @gallery = find_gallery
      @images = @gallery.images

      respond_to do |format|
        format.html # index.html.erb
        format.json do
          partial_str = render_to_string(file: 'bootsy/images/_index',
                                          formats: [:html],
                                          locals: { gallery: @gallery })
          render json: { partial: partial_str }
        end
      end
    end

    # POST /images
    # POST /images.json
    def create
      @gallery = find_gallery
      @gallery.save! unless @gallery.persisted?
      @image = Image.new image_params
      @image.image_gallery_id = @gallery.id

      respond_to do |format|
        if @image.save
          format.js
          format.json { render json: @image, status: :created, location: @image }
        else
          format.js
          format.json { render json: @image.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /images/1
    # DELETE /images/1.json
    def destroy
      @image = Image.find(params[:id])
      @image.destroy

      respond_to do |format|
        format.js
        format.html { redirect_to images_url }
        format.json { head :no_content }
      end
    end

    private
    def find_gallery
      ImageGallery.find_or_initialize_by(id: params[:image_gallery_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_params
      params.require(:image).permit(:image_file)
    end
  end
end
