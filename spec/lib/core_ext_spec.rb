# frozen_string_literal: true
require 'rails_helper'

describe 'Core Extensions' do
  describe ActionView::Helpers::FormBuilder do
    it 'includes Bootsy::FormBuilder' do
      expect(ActionView::Helpers::FormBuilder).to include(Bootsy::FormBuilder)
    end
  end

  describe ActionView::Base do
    it 'includes Bootsy::FormHelper' do
      expect(ActionView::Base).to include(Bootsy::FormHelper)
    end
  end
end
