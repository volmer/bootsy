require 'spec_helper'

describe Bootsy::Container do


  before :each do
    @post_with_gallery = Post.new title: 'Test', content: 'Test'
    @post_with_gallery.bootsy_image_gallery = FactoryGirl.create :image_gallery
    @post_with_gallery.save!
    @post = Post.new
  end

  it 'adds an image gallery' do
    @post.should respond_to(:bootsy_image_gallery)
  end

  describe '#bootsy_image_gallery' do
    it 'returns the resource which it belongs' do
      @post_with_gallery.bootsy_image_gallery.bootsy_resource.should eq(@post_with_gallery)
    end
  end

  describe '#bootsy_image_gallery_id' do
    it 'returns the gallery id if present' do
      @post_with_gallery.bootsy_image_gallery_id.should equal(@post_with_gallery.bootsy_image_gallery.id)
    end

    it 'returns nil if not present' do
      @post.bootsy_image_gallery_id.should be_nil
    end

    it 'sets an image gallery' do
      @g = FactoryGirl.create :image_gallery
      @post_with_gallery.bootsy_image_gallery_id = @g.id
      @post_with_gallery.save!

      @post_with_gallery.bootsy_image_gallery.should eq(@g)
      @post_with_gallery.bootsy_image_gallery_id.should eq(@g.id)
    end
  end
end