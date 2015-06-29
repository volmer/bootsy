require 'rails_helper'

describe 'editor customization', type: :feature, js: true do
  let(:options) do
    {
      font_styles: ['Font style'],
      color: ['Text color'],
      emphasis: %w(Bold Italic Underline),
      lists: ['Unordered list', 'Ordered list', 'Indent', 'Outdent'],
      link: ['Insert link'],
      image: ['Insert image'],
      html: ['Edit HTML']
    }
  end

  it 'allows enabling editor features' do
    options.keys.each do |config|
      allow(Bootsy).to receive(:editor_options).and_return(config => true)

      visit new_post_path

      options[config].each do |label|
        expect(find('ul.wysihtml5-toolbar')).to have_link(label)
      end
    end
  end

  it 'allows disabling editor features' do
    options.keys.each do |config|
      allow(Bootsy).to receive(:editor_options).and_return(config => false)

      visit new_post_path

      options[config].each do |label|
        expect(find('ul.wysihtml5-toolbar')).not_to have_link(label)
      end
    end
  end

  it 'allows disabling unsaved changes prompt' do
    allow(Bootsy).to receive(
      :editor_options).and_return('alert-unsaved' => false)
    visit new_post_path

    page.execute_script "Bootsy.areas.post_content.editor.fire('change')"
    visit root_path

    expect(current_path).to eq root_path
  end
end
