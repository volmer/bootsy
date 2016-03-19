require 'rails_helper'
require 'carrierwave/test/matchers'

describe Bootsy::ImageUploader do
  include CarrierWave::Test::Matchers

  describe 'respects dimensions' do
    before :all do
      path_to_file = Rails.root.to_s + '/public/test.jpg'
      @uploader = Bootsy::ImageUploader.new FactoryGirl.build(:image), :image_file
      @uploader.store! File.open(path_to_file)
    end

    after(:all) { @uploader.remove! }

    it 'respects dimensions for the original version' do
      expect(@uploader).to be_no_larger_than(1160, 2000)
    end

    it 'respects dimensions for the thumb version' do
      expect(@uploader.thumb).to have_dimensions(60, 60)
    end

    it 'respects dimensions for the small version' do
      expect(@uploader.small).to be_no_larger_than(Bootsy.small_image[:width], Bootsy.small_image[:height])
    end

    it 'respects dimensions for the medium version' do
      expect(@uploader.medium).to be_no_larger_than(Bootsy.medium_image[:width], Bootsy.medium_image[:height])
    end

    it 'respects dimensions for the large version' do
      expect(@uploader.large).to be_no_larger_than(Bootsy.large_image[:width], Bootsy.large_image[:height])
    end
  end

  describe 'deletes empty dirs' do
    it 'deletes empty dirs after remove' do
      path_to_file = Rails.root.to_s + '/public/test.jpg'
      @uploader = Bootsy::ImageUploader.new FactoryGirl.build(:image), :image_file
      @uploader.model.id = 99999 # some id to use a separate dir
      @uploader.store! File.open(path_to_file)
      expect(File).to exist File.expand_path(@uploader.store_dir, @uploader.root)
      @uploader.remove!
      expect(File).not_to exist File.expand_path(@uploader.store_dir, @uploader.root)
    end
  end
 end
