# frozen_string_literal: true
require 'rails_helper'

describe Bootsy::FormBuilder do
  let(:object) { Post.new }

  let(:template) { double('template') }

  subject do
    ActionView::Helpers::FormBuilder.new(:post, object, template, {})
  end

  describe '#bootsy_area' do
    it "is a proxy to the template's bootsy_area method" do
      expect(template).to receive(:bootsy_area)
        .with(:post, :content, object: object)

      subject.bootsy_area(:content)
    end

    it 'allows an optional hash of options' do
      expect(template).to receive(:bootsy_area)
        .with(:post, :content, op: 'op', object: object)

      subject.bootsy_area(:content, op: 'op')
    end
  end
end
