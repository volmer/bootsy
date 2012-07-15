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
    it "should limit 940 by 940 pixels" do
      @uploader.thumb.should be_no_larger_than(940, 940)
    end
  end

  context 'the thumb version' do
    it "should scale down an image to be exactly 60 by 60 pixels" do
      @uploader.thumb.should have_dimensions(60, 60)
    end
  end

  context 'the small version' do
    it "should limit 160 by 160 pixels" do
      @uploader.small.should be_no_larger_than(160, 160)
    end
  end

  context 'the medium version' do
    it "should limit 300 by 300 pixels" do
      @uploader.thumb.should be_no_larger_than(300, 300)
    end
  end

  context 'the large version' do
    it "should limit 600 by 600 pixels" do
      @uploader.thumb.should be_no_larger_than(600, 600)
    end
  end
end