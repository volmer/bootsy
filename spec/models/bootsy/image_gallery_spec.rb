require 'rails_helper'

describe Bootsy::ImageGallery do
  it { is_expected.to belong_to(:bootsy_resource) }
  it { is_expected.to have_many(:images).dependent(:destroy) }

  describe '.destroy_orphans' do
    it 'destroys all orphan galleries created before the given date' do
      ig1 = FactoryGirl.create(:image_gallery, created_at: 2.day.ago)
      ig2 = FactoryGirl.create(:image_gallery, created_at: 3.days.ago)
      ig3 = FactoryGirl.create(:image_gallery, created_at: 4.days.ago)

      Bootsy::ImageGallery.destroy_orphans(1.day.ago)

      expect(Bootsy::ImageGallery.all).to_not include(ig1, ig2, ig3)
    end

    it 'does not destroy orphan galleries created afther the given date' do
      ig1 = FactoryGirl.create(:image_gallery, created_at: 1.day.ago)
      ig2 = FactoryGirl.create(:image_gallery, created_at: 3.days.ago)
      ig3 = FactoryGirl.create(:image_gallery, created_at: 4.days.ago)

      Bootsy::ImageGallery.destroy_orphans(2.days.ago)

      expect(Bootsy::ImageGallery.all).to include(ig1)
    end

    it 'does not destroy non orphan galleries' do
      ig1 = FactoryGirl.create(:image_gallery, created_at: 2.day.ago)
      ig2 = FactoryGirl.create(:image_gallery, created_at: 3.days.ago, bootsy_resource: Post.create(title: 'a', content: 'b'))
      ig3 = FactoryGirl.create(:image_gallery, created_at: 4.days.ago)

      Bootsy::ImageGallery.destroy_orphans(1.day.ago)

      expect(Bootsy::ImageGallery.all).to include(ig2)
    end
  end

  it 'does not autosave its bootsy resource' do
    post = Post.new
    gallery = described_class.new
    gallery.bootsy_resource = post
    gallery.save!

    expect(post.errors).to be_empty
  end
end
