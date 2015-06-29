require 'rails_helper'

describe 'remote form', type: :feature, js: true do
  it 'works with Bootsy' do
    visit posts_path
    click_on 'New remote post'
    fill_in 'Title', with: 'Awesome post'
    click_on 'Insert image'
    attach_file 'image[image_file]', Rails.root.to_s + '/public/test.jpg'
    find(:xpath, "//div[contains(@class, 'bootsy-gallery')]//img[contains(@src"\
      ", '/thumb_test.jpg')]").click
    script = "$('.dropdown-submenu .dropdown-menu').hide(); "\
      "$('a:contains(Small):visible').parent()."\
      "find('.dropdown-menu').show()"

    page.execute_script(script)

    find(
      'li.dropdown-submenu ul.dropdown-menu li a',
      visible: true,
      text: /Left/
    ).click
    click_on 'Create Post'
    expect(page).to have_selector(
      :xpath, "//div[@id='posts']//img[contains(@src,'/small_test.jpg')]")
  end
end
