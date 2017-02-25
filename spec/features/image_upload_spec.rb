require 'rails_helper'
require 'sham_rack'
require 'spec_helper'

describe 'image upload', type: :feature, js: true do
  let(:thumb_selector) do
    "//div[contains(@class, 'bootsy-gallery')]//img[contains(@src, "\
      "'/thumb_test.jpg')]"
  end

  before do
    visit new_post_path
    click_on 'Insert image'

    ShamRack.at('stubhost.com').rackup do
      run Rack::Directory.new(Rails.root.join('public').to_s)
    end
  end

  it 'works with local files' do
    attach_file 'image[image_file]', Rails.root.to_s + '/public/test.jpg'
    wait_for_ajax

    expect(page).to have_selector(:xpath, thumb_selector, visible: true)
  end

  it 'works with remote files' do
    fill_in 'image[remote_image_file_url]', with: 'http://stubhost.com/test.jpg'
    click_on 'Go'
    wait_for_ajax

    expect(page).to have_selector(:xpath, thumb_selector, visible: true)
  end

  it 'handles invalid images' do
    attach_file 'image[image_file]', Rails.root.to_s + '/public/test.fake'
    wait_for_ajax

    expect(page).not_to have_selector(
      :xpath, "//div[contains(@class, 'bootsy-gallery')]//img", visible: true)
    expect(page).to have_content('You are not allowed to upload')
    click_on 'Refresh'
    wait_for_ajax

    expect(page).not_to have_content('You are not allowed to upload')
  end

  it 'handles invalid remote images' do
    fill_in 'image[remote_image_file_url]',
            with: 'http://stubhost.com/test.fake'
    click_on 'Go'
    wait_for_ajax

    expect(page).not_to have_selector(
      :xpath, "//div[contains(@class, 'bootsy-gallery')]//img", visible: true)
    expect(page).to have_content('You are not allowed to upload')
  end

  it 'associates the uploaded image with the resource' do
    attach_file 'image[image_file]', Rails.root.to_s + '/public/test.jpg'
    wait_for_ajax

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
    fill_in 'Title', with: 'Awesome post'
    click_on 'Create Post'
    click_on 'Edit'
    click_on 'Insert image'

    expect(page).to have_selector(:xpath, thumb_selector, visible: true)
  end
end
