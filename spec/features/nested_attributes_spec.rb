require 'rails_helper'

describe 'nested attributes', type: :feature, js: true do
  before do
    allow(Bootsy).to receive(:editor_options).and_return(alert_unsaved: false)
  end

  it 'is compatible with the editor' do
    visit root_path
    click_on 'New post with comment'
    fill_in 'Title', with: 'My post'
    page.execute_script 'document.querySelector("trix-editor.post-content")'\
      '.editor.insertString("Content")'
    fill_in 'Author', with: 'Comment author'
    page.execute_script 'document.querySelector("trix-editor.comment-content")'\
      '.editor.insertString("My comment")'
    click_on 'Create Post'

    expect(page).to have_content('My post')
    expect(page).to have_content('Content')
    expect(page).to have_content('Comment author')
    expect(page).to have_content('My comment')
  end
end
