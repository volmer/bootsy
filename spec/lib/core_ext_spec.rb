require 'spec_helper'

describe 'Core Extensions' do
  describe ActionView::Helpers::FormBuilder do
    it 'includes Bootsy::FormBuilder' do
      ActionView::Helpers::FormBuilder.should include(Bootsy::FormBuilder)
    end
  end

  describe ActionView::Helpers::FormHelper do
    it 'includes Bootsy::FormHelper' do
      ActionView::Helpers::FormHelper.should include(Bootsy::FormHelper)
    end
  end
end