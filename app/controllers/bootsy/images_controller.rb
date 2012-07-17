require_dependency "bootsy/application_controller"

module Bootsy
  class ImagesController < Bootsy::ApplicationController
    # GET /images
    # GET /images.json
    def index
      @gallery = find_gallery
      @images = @gallery.images

      respond_to do |format|
        format.js
        format.html # index.html.erb
        format.json { render json: @images }
      end
    end

    # POST /images
    # POST /images.json
    def create
      @gallery = find_gallery
      @gallery.save! unless @gallery.persisted?
      @image = @gallery.images.new params[:image]
  
      respond_to do |format|
        if @image.save
          @images = @gallery.images
          format.js
          format.json { render json: @image, status: :created, location: @image }
        else
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
      begin 
        return ImageGallery.find params[:image_gallery_id]
      rescue
        return ImageGallery.new
      end
    end
  end
end
