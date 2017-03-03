# frozen_string_literal: true
require 'rails_helper'

describe 'foreign gallery', type: :feature, js: true do
  it 'is possible' do
    post = Post.new(title: 'Test', content: 'test')
    post.bootsy_image_gallery_id = FactoryGirl.create(
      :image_gallery_with_images
    ).id
    post.save!
    visit post_path(post)
    click_on 'Insert image'
    expect(page).to have_css('.bootsy-modal', visible: true)
    expect(page).to have_css('.bootsy-image', visible: true)
  end

  it 'allows uploads' do
    post = Post.new(title: 'Test', content: 'test')
    post.save!
    visit post_path(post)

    click_on 'Insert image'
    attach_file 'image[image_file]', Rails.root.to_s + '/public/test.jpg'
    find('[data-dismiss=modal]').click
    click_on 'Create Comment'
    click_on 'Edit'
    click_on 'Insert image'
    selector = "//div[contains(@class, 'bootsy-gallery')]//img[contains(@src, "\
      "'/thumb_test.jpg')]"
    expect(page).to have_selector(:xpath, selector, visible: true)
  end
end
