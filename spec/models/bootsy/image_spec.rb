require 'spec_helper'

describe Bootsy::Image do
  it { should belong_to(:image_gallery) }

  it { should validate_presence_of(:image_file) }
  it { should validate_presence_of(:image_gallery_id) }

  its(:image_file){ should be_an_instance_of(Bootsy::ImageUploader) }

  it { should allow_mass_assignment_of(:image_file) }
end
