require 'spec_helper'

describe ActionView::Helpers::FormHelper do
  class DummyClass < ActionView::Base
  end


  before :each do
    @f = DummyClass.new
    @f.extend ActionView::Helpers::FormHelper
  end

  it 'has the method bootsy_area' do
    @f.should respond_to(:bootsy_area)
  end
end