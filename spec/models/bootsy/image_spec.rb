require 'spec_helper'

describe Bootsy::Image do
  before :each do
    @image = FactoryGirl.build :image
  end

  it 'is valid with proper values' do
    @image.should be_valid
  end

  it 'is not valid without a gallery' do
    @image.image_gallery = nil
    @image.should_not be_valid
  end

  it 'is not valid without an image file' do
    @image.remove_image_file!
    @image.should_not be_valid
  end
end
