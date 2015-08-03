require 'rails_helper'

describe 'image insertion', type: :feature, js: true do
  let(:size_positions) do
    [
      %w(Small Left),
      %w(Small Right),
      %w(Small Inline),
      %w(Medium Left),
      %w(Medium Right),
      %w(Medium Inline),
      %w(Large Left),
      %w(Large Right),
      %w(Large Inline),
      %w(Original Left),
      %w(Original Right),
      %w(Original Inline)
    ]
  end

  it 'can be performed' do
    size_positions.each do |size_position|
      visit new_post_path
      click_on 'Insert image'
      attach_file 'image[image_file]', Rails.root.to_s + '/public/test.jpg'

      find(:xpath, "//div[contains(@class, 'bootsy-gallery')]//img").click
      size = size_position.first
      position = size_position.last
      script = "$('.dropdown-submenu .dropdown-menu').hide(); "\
        "$('a:contains(#{size}):visible').parent()."\
        "find('.dropdown-menu').show()"
      page.execute_script(script)
      find('li.dropdown-submenu ul.dropdown-menu li a', text: position).click

      content = page.evaluate_script(
        'Bootsy.areas.post_content.editor.getValue()'
      )

      img_src = "/#{size.downcase}_test.jpg"
      img_src = '/test.jpg' if size == 'Original'
      image_css = "img.wysiwyg-float-#{position.downcase}[src$='#{img_src}']"

      expect(Capybara.string(content)).to have_css(image_css)
    end
  end
end
