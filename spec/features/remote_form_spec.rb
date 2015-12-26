require 'rails_helper'

describe 'remote form', type: :feature, js: true do
  before do
    allow(Bootsy).to receive(:editor_options).and_return(alert_unsaved: false)
  end

  it 'works with Bootsy' do
    visit posts_path
    click_on 'New remote post'
    fill_in 'Title', with: 'Awesome post'
    click_on 'Insert image'
    attach_file 'image[image_file]', Rails.root.to_s + '/public/test.jpg'
    find('.bootsy-gallery img[src$="/thumb_test.jpg"]').click
    click_on 'Small'

    sleep 1
    click_button 'Create Post'

    expect(page).to have_css('#posts img[src$="/small_test.jpg"]')
  end
end
