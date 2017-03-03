# frozen_string_literal: true
require 'rails_helper'

# To ensure this feature there is the ability to
# edit comments in the dummy app. To edit comments the
# user needs to click on the "edit" link, and then
# a hidden editor becomes visible.

# It is important to ensure this feature due to some
# issues with Firefox and hidden elements.

describe 'hidden editor', type: :feature, js: true do
  it 'works' do
    post = Post.create!(title: 'Test', content: 'test')
    Comment.create!(post: post, author: 'someone', content: 'Nice post!')
    visit post_path(post)

    click_on 'Edit comment'
    page.execute_script "Bootsy.areas['comment_content'].editor."\
      "setValue('Edited content')"
    click_on 'Update Comment'

    expect(page).to have_content('Comment was updated')
    expect(page).to have_content('Edited content')
  end
end
