require 'spec_helper'

describe "image_galleries/new" do
  before(:each) do
    assign(:image_gallery, stub_model(ImageGallery).as_new_record)
  end

  it "renders new image_gallery form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => image_galleries_path, :method => "post" do
    end
  end
end
