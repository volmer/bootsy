# frozen_string_literal: true
require 'rails_helper'

describe 'image gallery modal', type: :feature, js: true do
  it 'is accessible with a new resource' do
    visit new_post_path

    click_on 'Insert image'

    expect(page).to have_css('.bootsy-modal', visible: true)
    expect(page).not_to have_css('.bootsy-image', visible: true)
    expect(page).to have_content('There are currently no uploaded images.')
  end

  it 'is accessible with a persisted resource' do
    post = Post.new(title: 'Test', content: 'test')
    post.bootsy_image_gallery_id = FactoryGirl.create(
      :image_gallery_with_images
    ).id
    post.save!
    visit edit_post_path(post)

    click_on 'Insert image'

    expect(page).to have_css('.bootsy-modal', visible: true)
    expect(page).to have_css('.bootsy-image', visible: true)
  end
end
