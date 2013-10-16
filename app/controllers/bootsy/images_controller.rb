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
          rendered_images = []

          @images.each do |image|
            rendered_images << render_to_string(file: 'bootsy/images/_image',
                                          formats: [:html],
                                          locals: { image: image })
          end

          new_image = render_to_string(file: 'bootsy/images/_new',
                                        formats: [:html],
                                        locals: { gallery: @gallery, image: @gallery.images.new })

          render json: { images: rendered_images, form: new_image }
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
      ImageGallery.find params[:image_gallery_id]
    rescue
      ImageGallery.new
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_params
      params.require(:image).permit(:image_file)
    end
  end
end
