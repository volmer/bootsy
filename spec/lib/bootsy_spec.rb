require 'spec_helper'

describe Bootsy do
  describe '.setup' do
    it 'yields self' do
      Bootsy.setup do |config|
        config.should == Bootsy
      end
    end
  end
end