# frozen_string_literal: true
require 'rails_helper'
require 'carrierwave/test/matchers'

describe Bootsy::ImageUploader do
  include CarrierWave::Test::Matchers

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
    expect(@uploader.small).to be_no_larger_than(
      Bootsy.small_image[:width], Bootsy.small_image[:height]
    )
  end

  it 'respects dimensions for the medium version' do
    expect(@uploader.medium).to be_no_larger_than(
      Bootsy.medium_image[:width], Bootsy.medium_image[:height]
    )
  end

  it 'respects dimensions for the large version' do
    expect(@uploader.large).to be_no_larger_than(
      Bootsy.large_image[:width], Bootsy.large_image[:height]
    )
  end
end
