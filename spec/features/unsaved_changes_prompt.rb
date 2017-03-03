# frozen_string_literal: true
require 'rails_helper'

describe 'unsaved changes prompt', type: :feature, js: true do
  before do
    visit new_post_path
    page.execute_script "Bootsy.areas.post_content.editor.fire('change')"
    visit root_path
  end

  after do
    page.execute_script 'if(Bootsy.areas.post_content) { '\
      'Bootsy.areas.post_content.unsavedChanges = false; }'
  end

  it 'can be accepted' do
    page.driver.browser.switch_to.alert.accept
    expect(current_path).to eq root_path
  end

  it 'can be dismissed' do
    page.driver.browser.switch_to.alert.dismiss
    expect(current_path).to eq new_post_path
  end
end
