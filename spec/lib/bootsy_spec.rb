require 'spec_helper'

describe Bootsy do
  subject { Bootsy }

  describe '.setup' do
    it 'yields self' do
      subject.setup do |config|
        config.should == subject
      end
    end
  end

  describe 'default values' do
    its(:image_versions_available) { should == [:small, :medium, :large, :original] }

    its(:allow_destroy) { should == true }

    its(:small_image) { should == {width: 160, height: 160} }

    its(:medium_image) { should == {width: 360, height: 360} }

    its(:large_image) { should == {width: 760, height: 760} }

    its(:original_image) { should == {} }

    its(:store_dir) { should == 'uploads' }

  end
end