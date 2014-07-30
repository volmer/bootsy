require 'rails_helper'

describe 'Core Extensions' do
  describe ActionView::Helpers::FormBuilder do
    it { ActionView::Helpers::FormBuilder.should include(Bootsy::FormBuilder) }
  end

  describe ActionView::Base do
    it { ActionView::Base.should include(Bootsy::FormHelper) }
  end
end
