Given("I've changed the content of the text area") do
  page.execute_script "Bootsy.areas.post_content.editor.fire('change')"
end

When('I change the content of the text area') do
  page.execute_script "Bootsy.areas.post_content.editor.fire('change')"
end

When(/^I set "(.*?)" to "(.*?)" on the editor options of bootsy_area$/) do |option, value|
  Bootsy.stub(editor_options: { option => value })
end

When(/^I fill in the "(.*?)" editor with "(.*?)"$/) do |editor, value|
  page.execute_script "Bootsy.areas['#{ editor }'].editor.setValue('#{ value }')"
end

Then(/^I( don't)? see a link with the option "(.*?)" in the editor toolbar$/) do |negate, option|
  expectation = negate ? :not_to : :to

  expect(find('ul.wysihtml5-toolbar')).send(expectation, have_link(option))
end
