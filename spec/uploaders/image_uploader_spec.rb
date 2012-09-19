require 'spec_helper'
require 'carrierwave/test/matchers'

describe Bootsy::ImageUploader do
  include CarrierWave::Test::Matchers

  before :each do
    path_to_file = Rails.root.to_s + "/public/test.jpg"
    @uploader = Bootsy::ImageUploader.new FactoryGirl.build(:image), :image_file
    @uploader.store! File.open(path_to_file)
  end

  after do
    @uploader.remove!
  end

  context 'the original version' do
    it "should limit 1160 by 2000 pixels" do
      @uploader.should be_no_larger_than(1160, 2000)
    end
  end

  context 'the thumb version' do
    it "should scale down an image to be exactly 60 by 60 pixels" do
      @uploader.thumb.should have_dimensions(60, 60)
    end
  end

  context 'the small version' do
    it "should limit to dimensions defined at Bootsy.small_image" do
      @uploader.small.should be_no_larger_than(Bootsy.small_image[:width], Bootsy.small_image[:height])
    end
  end

  context 'the medium version' do
    it "should limit to dimensions defined at Bootsy.medium_image" do
      @uploader.thumb.should be_no_larger_than(Bootsy.medium_image[:width], Bootsy.medium_image[:height])
    end
  end

  context 'the large version' do
    it "should limit to dimensions defined at Bootsy.large_image" do
      @uploader.thumb.should be_no_larger_than(Bootsy.large_image[:width], Bootsy.large_image[:height])
    end
  end
end