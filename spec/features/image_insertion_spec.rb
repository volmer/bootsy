require 'rails_helper'

describe 'image insertion', type: :feature, js: true do
  let(:sizes) do
    %w(Small Medium Large Original)
  end

  it 'can be performed' do
    sizes.each do |size|
      visit new_post_path
      click_on 'Insert image'
      attach_file 'image[image_file]', Rails.root.to_s + '/public/test.jpg'

      find('.bootsy-gallery img').click

      click_on(size)

      content = page.find('trix-editor').value

      img_src = "/#{size.downcase}_test.jpg"
      img_src = 'test.jpg' if size == 'Original'

      expect(content).to include(img_src)
    end
  end
end
