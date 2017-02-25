require 'rails_helper'

describe Bootsy do
  subject { Bootsy }

  describe '.setup' do
    it 'yields self' do
      subject.setup do |config|
        expect(config).to eq subject
      end
    end
  end

  describe 'default values' do
    describe '.editor_options' do
      subject { Bootsy.editor_options }

      it { is_expected.to include(font_styles: true) }
      it { is_expected.to include(lists: true) }
      it { is_expected.to include(emphasis: true) }
      it { is_expected.to include(html: false) }
      it { is_expected.to include(image: true) }
      it { is_expected.to include(color: true) }
    end

    it 'has defaults for image_versions_available' do
      expect(subject.image_versions_available).to eq [:small, :medium, :large, :original]
    end

    it 'has defaults for allow_destroy' do
      expect(subject.allow_destroy).to be true
    end

    it 'has defaults for small_image' do
      expect(subject.small_image).to eq({ width: 160, height: 160 })
    end

    it 'has defaults for medium_image' do
      expect(subject.medium_image).to eq({ width: 360, height: 360 })
    end

    it 'has defaults for large_image' do
      expect(subject.large_image).to eq({ width: 760, height: 760 })
    end

    it 'has defaults for original_image' do
      expect(subject.original_image).to be_empty
    end

    it 'has defaults for store_dir' do
      expect(subject.store_dir).to eq 'uploads'
    end

    it 'has defaults for mailer' do
      expect(subject.uploader).to eq "Bootsy::ImageUploader"
    end
  end
end
