require 'spec_helper'

describe "image_galleries/index" do
  before(:each) do
    assign(:image_galleries, [
      stub_model(ImageGallery),
      stub_model(ImageGallery)
    ])
  end

  it "renders a list of image_galleries" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
