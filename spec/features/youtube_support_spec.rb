# frozen_string_literal: true
require 'rails_helper'

describe 'YouTube support', type: :feature, js: true do
  it 'allows YouTube embed codes' do
    visit new_post_path

    embed = '<iframe width="560" height="315" src="//www.youtube.com/embed/d2Q'\
      'dITRRMHg" frameborder="0" allowfullscreen></iframe>'
    page.execute_script "Bootsy.areas.post_content.editor.setValue('#{embed}')"

    expected_embed = '<iframe width="560" height="315" src="//www.youtube.com'\
      '/embed/d2QdITRRMHg" frameborder="0" allowfullscreen=""></iframe>'
    content = page.evaluate_script(
      'Bootsy.areas.post_content.editor.getValue()'
    )
    expect(content).to include(expected_embed)
  end
end
