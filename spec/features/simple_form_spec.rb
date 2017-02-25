require 'rails_helper'
require 'spec_helper'

describe 'simple form', type: :feature, js: true do
  it 'is compatible with Bootsy' do
    visit new_simple_form_post_path
    click_on 'Insert image'
    attach_file 'image[image_file]', Rails.root.to_s + '/public/test.jpg'
    wait_for_ajax
    selector = "//div[contains(@class, 'bootsy-gallery')]//img[contains(@src, "\
      "'/thumb_test.jpg')]"

    expect(page).to have_selector(:xpath, selector, visible: true)
  end
end
