require 'rails_helper'

describe 'remote form', type: :feature, js: true do
  it 'works with Bootsy' do
    visit posts_path
    click_on 'New remote post'
    fill_in 'Title', with: 'Awesome post'
    click_on 'Insert image'
    attach_file 'image[image_file]', Rails.root.to_s + '/public/test.jpg'
    find('.bootsy-gallery img[src$="/thumb_test.jpg"]').click
    script = "$('.dropdown-submenu .dropdown-menu').hide(); "\
      "$('a:contains(Small):visible').parent()."\
      "find('.dropdown-menu').show()"

    page.execute_script(script)

    find(
      '.dropdown-submenu .dropdown-menu a',
      visible: true,
      text: /Left/
    ).click

    sleep 1
    click_button 'Create Post'

    expect(page).to have_css('#posts img[src$="/small_test.jpg"]')
  end
end
