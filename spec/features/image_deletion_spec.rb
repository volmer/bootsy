require 'rails_helper'

describe 'image deletion', type: :feature, js: true do
  let(:selector) do
    "//div[contains(@class, 'bootsy-gallery')]//img[contains(@src, "\
    "'/thumb_test.jpg')]"
  end

  before do
    visit new_post_path
    click_on 'Insert image'
    attach_file 'image[image_file]', Rails.root.to_s + '/public/test.jpg'
  end

  it 'can be performed' do
    find(:xpath, selector).click

    click_link 'Delete'
    page.driver.browser.switch_to.alert.accept

    expect(page).not_to have_selector(:xpath, selector, visible: true)
    expect(page).to have_content('There are currently no uploaded images.')
  end

  it 'can be interrupted' do
    find(:xpath, selector).click

    click_link 'Delete'
    page.driver.browser.switch_to.alert.dismiss

    expect(page).to have_selector(:xpath, selector, visible: true)
  end
end
