require 'rails_helper'

describe 'Toolbar', type: :feature, js: true do
  let(:options) do
    {
      bold: 'Bold',
      italic: 'Italic',
      strike: 'Strikethrough',
      link: 'Link',
      quote: 'Quote',
      code: 'Code',
      bullets: 'Bullets',
      numbers: 'Numbers',
      decrease_block_level: 'Decrease Level',
      increase_block_level: 'Increase Level',
      undo: 'Undo',
      redo: 'Redo'
    }
  end

  it 'allows enabling certain buttons' do
    options.each do |config, title|
      allow(Bootsy).to receive(:editor_options).and_return(config => true)

      visit new_post_path

      expect(find('trix-toolbar')).to have_css(
        "button[title='#{title}']"), "expected toolbar to include #{title}"
    end
  end

  it 'allows disabling certain buttons' do
    options.each do |config, title|
      allow(Bootsy).to receive(:editor_options).and_return(config => false)

      visit new_post_path

      expect(find('trix-toolbar')) .to have_no_css(
        "button[title='#{title}']"), "expected toolbar not to include #{title}"
    end
  end
end
