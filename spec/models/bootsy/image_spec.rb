require 'rails_helper'

describe Bootsy::Image do
  it { should belong_to(:image_gallery) }
  it { should validate_presence_of(:image_gallery_id) }

  describe '#image_file' do
    it 'is a Bootsy uploader' do
      expect(subject.image_file).to be_a(Bootsy::ImageUploader)
    end

    it 'is required' do
      subject.valid?

      expect(subject.errors[:image_file].size).to eq 1
    end
  end
end
