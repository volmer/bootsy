require 'spec_helper'
require 'carrierwave/test/matchers'

describe Bootsy::ImageUploader do
  include CarrierWave::Test::Matchers

  before :all do
    path_to_file = Rails.root.to_s + "/public/test.jpg"
    @uploader = Bootsy::ImageUploader.new FactoryGirl.build(:image), :image_file
    @uploader.store! File.open(path_to_file)
  end

  subject { @uploader }

  after(:all) { @uploader.remove! }

  context 'the original version' do
    it { should be_no_larger_than(1160, 2000) }
  end

  its(:thumb){ should have_dimensions(60, 60) }

  its(:small){ should be_no_larger_than(Bootsy.small_image[:width], Bootsy.small_image[:height]) }

  its(:medium){ should be_no_larger_than(Bootsy.medium_image[:width], Bootsy.medium_image[:height]) }

  its(:large){ should be_no_larger_than(Bootsy.large_image[:width], Bootsy.large_image[:height]) }
end