require 'spec_helper'

describe 'Core Extensions' do
  describe ActionView::Helpers::FormBuilder do
    it 'includes Bootsy::FormBuilder' do
      ActionView::Helpers::FormBuilder.should include(Bootsy::FormBuilder)
    end
  end

  describe ActionView::Base do
    it 'includes Bootsy::FormHelper' do
      ActionView::Base.should include(Bootsy::FormHelper)
    end
  end
end