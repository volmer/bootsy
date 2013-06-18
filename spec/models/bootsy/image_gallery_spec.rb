require 'spec_helper'

describe Bootsy::ImageGallery do
  it { should belong_to(:bootsy_resource) }
  it { should have_many(:images).dependent(:destroy) }

  describe '.destroy_orphans' do
    it 'destroys all orphan galleries created before the given date' do
      ig1 = FactoryGirl.create(:image_gallery, created_at: 2.day.ago)
      ig2 = FactoryGirl.create(:image_gallery, created_at: 3.days.ago)
      ig3 = FactoryGirl.create(:image_gallery, created_at: 4.days.ago)

      Bootsy::ImageGallery.recycle(1.day.ago)

      expect(Bootsy::ImageGallery.all).to be_empty
    end


    it 'does not destroy orphan galleries created afther the given date' do
      ig1 = FactoryGirl.create(:image_gallery, created_at: 1.day.ago)
      ig2 = FactoryGirl.create(:image_gallery, created_at: 3.days.ago)
      ig3 = FactoryGirl.create(:image_gallery, created_at: 4.days.ago)

      Bootsy::ImageGallery.recycle(2.days.ago)

      expect(Bootsy::ImageGallery.all).to eq([ig1])
    end

    it 'does not destroy non orphan galleries' do
      ig1 = FactoryGirl.create(:image_gallery, created_at: 2.day.ago)
      ig2 = FactoryGirl.create(:image_gallery, created_at: 3.days.ago, bootsy_resource: Post.create(title: 'a', content: 'b'))
      ig3 = FactoryGirl.create(:image_gallery, created_at: 4.days.ago)

      Bootsy::ImageGallery.recycle(1.day.ago)

      expect(Bootsy::ImageGallery.all).to eq([ig2])
    end
  end
end
