require 'rails_helper'

describe 'unsaved changes prompt', type: :feature, js: true do
  before do
    visit new_post_page
    page.execute_script "Bootsy.areas.post_content.editor.fire('change')"
  end

  it 'can be accepted' do
    visit root_path
    page.driver.browser.switch_to.alert.accept

    expect(current_path).to eq root_path
  end

  it 'can be dismissed' do
    visit root_path
    page.driver.browser.switch_to.alert.dismiss

    expect(current_path).to eq new_post_page
  end
end
