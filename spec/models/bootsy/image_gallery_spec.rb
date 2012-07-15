require 'spec_helper'

describe Bootsy::ImageGallery do
  it 'is valid with proper values and no images' do
    ig = FactoryGirl.build :image_gallery
    ig.should be_valid
    ig.images.should be_empty
  end

  it 'is valid with proper values and some images' do
    ig = FactoryGirl.create :image_gallery_with_images
    ig.should be_valid
    ig.images.should_not be_empty
  end

end
