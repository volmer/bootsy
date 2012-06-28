require 'spec_helper'

describe "image_galleries/edit" do
  before(:each) do
    @image_gallery = assign(:image_gallery, stub_model(ImageGallery))
  end

  it "renders the edit image_gallery form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => image_galleries_path(@image_gallery), :method => "post" do
    end
  end
end
