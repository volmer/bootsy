# frozen_string_literal: true
require 'rails_helper'

describe 'nested attributes', type: :feature, js: true do
  it 'is compatible with the editor' do
    visit root_path
    click_on 'New post with comment'
    fill_in 'Title', with: 'My post'
    page.execute_script "Bootsy.areas.post_content.editor.setValue('Content')"
    fill_in 'Author', with: 'Comment author'
    page.execute_script 'Bootsy.areas.post_comments_attributes_0_content.'\
      "editor.setValue('My comment')"
    click_on 'Create Post'

    expect(page).to have_content('My post')
    expect(page).to have_content('Content')
    expect(page).to have_content('Comment author')
    expect(page).to have_content('My comment')
  end
end
