require_dependency "bootsy/application_controller"

module Bootsy
  class ImageGalleriesController < ApplicationController
    # GET /image_galleries
    # GET /image_galleries.json
    def index
      @image_galleries = ImageGallery.all
  
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @image_galleries }
      end
    end
  
    # GET /image_galleries/1
    # GET /image_galleries/1.json
    def show
      @image_gallery = ImageGallery.find(params[:id])
  
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @image_gallery }
      end
    end
  
    # GET /image_galleries/new
    # GET /image_galleries/new.json
    def new
      @image_gallery = ImageGallery.new
  
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @image_gallery }
      end
    end
  
    # GET /image_galleries/1/edit
    def edit
      @image_gallery = ImageGallery.find(params[:id])
    end
  
    # POST /image_galleries
    # POST /image_galleries.json
    def create
      @image_gallery = ImageGallery.new(params[:image_gallery])
  
      respond_to do |format|
        if @image_gallery.save
          format.html { redirect_to @image_gallery, notice: 'Image gallery was successfully created.' }
          format.json { render json: @image_gallery, status: :created, location: @image_gallery }
        else
          format.html { render action: "new" }
          format.json { render json: @image_gallery.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PUT /image_galleries/1
    # PUT /image_galleries/1.json
    def update
      @image_gallery = ImageGallery.find(params[:id])
  
      respond_to do |format|
        if @image_gallery.update_attributes(params[:image_gallery])
          format.html { redirect_to @image_gallery, notice: 'Image gallery was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @image_gallery.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /image_galleries/1
    # DELETE /image_galleries/1.json
    def destroy
      @image_gallery = ImageGallery.find(params[:id])
      @image_gallery.destroy
  
      respond_to do |format|
        format.html { redirect_to image_galleries_url }
        format.json { head :no_content }
      end
    end
  end
end
