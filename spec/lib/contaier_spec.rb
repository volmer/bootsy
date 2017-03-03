# frozen_string_literal: true
require 'rails_helper'

describe Bootsy::Container do
  let(:post) { Post.new }

  let(:post_with_gallery) do
    post_with_gallery = Post.new(title: 'Test', content: 'Test')
    post_with_gallery.bootsy_image_gallery = FactoryGirl.create(:image_gallery)
    post_with_gallery.save!
    post_with_gallery
  end

  it 'adds an image gallery' do
    expect(post).to respond_to(:bootsy_image_gallery)
  end

  describe '#bootsy_image_gallery' do
    it 'returns the resource which it belongs' do
      expect(post_with_gallery.bootsy_image_gallery.bootsy_resource)
        .to eq(post_with_gallery)
    end
  end

  describe '#bootsy_image_gallery_id' do
    it 'returns the gallery id if present' do
      expect(post_with_gallery.bootsy_image_gallery_id)
        .to eq(post_with_gallery.bootsy_image_gallery.id)
    end

    it 'returns nil if not present' do
      expect(post.bootsy_image_gallery_id).to be_nil
    end
  end

  describe '#bootsy_image_gallery_id=' do
    let(:image_gallery) { FactoryGirl.create(:image_gallery) }

    it 'sets an image gallery if container does not have one yet' do
      post.bootsy_image_gallery_id = image_gallery.id

      expect(post.bootsy_image_gallery).to eq(image_gallery)
      expect(post.bootsy_image_gallery_id).to eq(image_gallery.id)
    end

    it 'does not set an image gallery if container already has a gallery' do
      post_with_gallery.bootsy_image_gallery_id = image_gallery.id

      expect(post_with_gallery.bootsy_image_gallery_id)
        .not_to eq(image_gallery.id)
    end
  end
end
