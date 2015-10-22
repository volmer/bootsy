require 'rails_helper'
require 'carrierwave/test/matchers'

describe Bootsy::ImageUploader do
  include CarrierWave::Test::Matchers

  before do
    path_to_file = Rails.root.to_s + '/public/test.jpg'
    @uploader = Bootsy::ImageUploader.new
    @uploader.store! File.open(path_to_file)
  end

  after { @uploader.remove! }

  it 'respects max dimensions' do
    expect(@uploader).to be_no_larger_than(1160, 2000)
  end
end
