# frozen_string_literal: true
require 'rails_helper'

describe 'editor customization', type: :feature, js: true do
  let(:options) do
    {
      color: ['Black'],
      emphasis: %w(Bold Italic Underline),
      font_styles: ['Normal text'],
      html: ['Edit HTML'],
      image: ['Insert image'],
      link: ['Insert link'],
      lists: ['Unordered list', 'Ordered list', 'Indent', 'Outdent']
    }
  end

  it 'allows enabling editor features' do
    options.keys.each do |config|
      allow(Bootsy).to receive(:editor_options).and_return(config => true)

      visit new_post_path

      toolbar = find('ul.wysihtml5-toolbar')

      options[config].each do |label|
        expect(
          toolbar.has_css?('a', text: label) ||
          toolbar.has_css?("a[title='#{label}']")
        ).to be(true), "expected toolbar to include #{label}"
      end
    end
  end

  it 'allows disabling editor features' do
    options.keys.each do |config|
      allow(Bootsy).to receive(:editor_options).and_return(config => false)

      visit new_post_path

      toolbar = find('ul.wysihtml5-toolbar')

      options[config].each do |label|
        expect(toolbar).not_to have_css('a', text: label)
        expect(toolbar).not_to have_css("a[title='#{label}']")
      end
    end
  end

  it 'allows disabling unsaved changes prompt' do
    allow(Bootsy).to receive(
      :editor_options
    ).and_return('alert-unsaved' => false)
    visit new_post_path

    page.execute_script "Bootsy.areas.post_content.editor.fire('change')"
    visit root_path

    expect(current_path).to eq root_path
  end
end
