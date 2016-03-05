require 'rails_helper'

describe Bootsy::ApplicationHelper do
  let(:unsaved_gallery) { FactoryGirl.build(:image_gallery) }
  let(:saved_gallery) { FactoryGirl.create(:image_gallery) }

  describe '#refresh_btn' do
    subject { helper.refresh_btn }

    it { is_expected.to include('class="btn btn-secondary btn-sm refresh-btn"') }

    it { is_expected.to include('Refresh') }

    it { is_expected.to include('href="#refresh-gallery"') }
  end

  describe '#resource_or_nil' do
    context 'argument is nil' do
      subject { helper.resource_or_nil nil }

      it { is_expected.to be_nil }
    end

    context 'argument is not persisted' do
      subject { helper.resource_or_nil unsaved_gallery }

      it { is_expected.to be_nil }
    end

    context 'argument is persisted' do
      subject { helper.resource_or_nil saved_gallery }

      it 'returns the given argument' do
        expect(subject).to eq saved_gallery
      end
    end
  end
end
