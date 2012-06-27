require_dependency "bootsy/application_controller"

module Bootsy
  class ImagesController < ApplicationController
    # GET /images
    # GET /images.json
    def index
      @resource = find_resource
      @images = @resource.bootsy_images

      respond_to do |format|
        format.js
        format.html # index.html.erb
        format.json { render json: @images }
      end
    end

    # POST /images
    # POST /images.json
    def create
      @image = Image.new(params[:image])
      @resource = find_resource
      @image.bootsy_imageable = @resource
  
      respond_to do |format|
        if @image.save
          format.js #{ render action: 'create'}
          format.json { render json: @image, status: :created, location: @image }
        else
          format.json { render json: @image.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PUT /images/1
    # PUT /images/1.json
    def update
      @image = Image.find(params[:id])
  
      respond_to do |format|
        if @image.update_attributes(params[:image])
          format.html { redirect_to @image, notice: 'Image was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
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
    def find_resource
      params.each do |name, value|
        if name =~ /(.+)_id$/
          return $1.classify.constantize.find(value)
        end
        if value.is_a? Hash
          return name.classify.constantize.find(value[:id]) unless value[:id].blank?
        end
      end
      nil
    end
  end
end
