# frozen_string_literal: true
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
end
