require "spec_helper"

describe ImageGalleriesController do
  describe "routing" do

    it "routes to #index" do
      get("/image_galleries").should route_to("image_galleries#index")
    end

    it "routes to #new" do
      get("/image_galleries/new").should route_to("image_galleries#new")
    end

    it "routes to #show" do
      get("/image_galleries/1").should route_to("image_galleries#show", :id => "1")
    end

    it "routes to #edit" do
      get("/image_galleries/1/edit").should route_to("image_galleries#edit", :id => "1")
    end

    it "routes to #create" do
      post("/image_galleries").should route_to("image_galleries#create")
    end

    it "routes to #update" do
      put("/image_galleries/1").should route_to("image_galleries#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/image_galleries/1").should route_to("image_galleries#destroy", :id => "1")
    end

  end
end
