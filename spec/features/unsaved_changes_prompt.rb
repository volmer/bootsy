require 'rails_helper'

describe 'unsaved changes prompt', type: :feature, js: true do
  let(:alert_unsaved) { true }

  before do
    allow(Bootsy).to receive(:editor_options).and_return(
      alert_unsaved: alert_unsaved)

    visit new_post_path
    page.execute_script "Bootsy.areas[0].editor.insertString('change')"
    visit root_path
  end

  after do
    page.execute_script 'if(Bootsy.areas[0]) { Bootsy.areas[0].unsavedChanges = false; }'
  end

  it 'can be accepted' do
    page.driver.browser.switch_to.alert.accept
    expect(current_path).to eq root_path
  end

  it 'can be dismissed' do
    page.driver.browser.switch_to.alert.dismiss
    expect(current_path).to eq new_post_path
  end

  context 'when prompt is disabled via configuration' do
    let(:alert_unsaved) { false }

    it 'does not show up' do
      expect(current_path).to eq root_path
    end
  end
end
