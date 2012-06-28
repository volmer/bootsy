require 'spec_helper'

describe "image_galleries/show" do
  before(:each) do
    @image_gallery = assign(:image_gallery, stub_model(ImageGallery))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
