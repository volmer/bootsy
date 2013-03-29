require 'spec_helper'

describe Bootsy::ImageGallery do
  it { should belong_to(:bootsy_resource) }
  it { should have_many(:images).dependent(:destroy) }
end
