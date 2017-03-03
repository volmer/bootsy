# frozen_string_literal: true
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

    page.accept_confirm 'Are you sure you want to delete this image?' do
      click_link 'Delete'
    end

    expect(page).not_to have_selector(:xpath, selector, visible: true)
    expect(page).to have_content('There are currently no uploaded images.')
  end

  it 'can be interrupted' do
    find(:xpath, selector).click

    page.dismiss_confirm 'Are you sure you want to delete this image?' do
      click_link 'Delete'
    end

    expect(page).to have_selector(:xpath, selector, visible: true)
  end
end
