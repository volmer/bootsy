Given("I've changed the content of the text area") do
  page.execute_script "Bootsy.areas.post_content.editor.fire('change')"
end

When('I change the content of the text area') do
  page.execute_script "Bootsy.areas.post_content.editor.fire('change')"
end

When(/^I set "(.*?)" to "(.*?)" on the editor options of bootsy_area$/) do |option, value|
  allow(Bootsy).to receive(:editor_options).and_return(option => value)
end

When(/^I fill in the "(.*?)" editor with "(.*?)"$/) do |editor, value|
  page.execute_script "Bootsy.areas['#{ editor }'].editor.setValue('#{ value }')"
end

When(/^I paste an YouTube video markup$/) do
  embed = '<iframe width="560" height="315" src="//www.youtube.com/embed/d2QdITRRMHg" frameborder="0" allowfullscreen></iframe>'

  page.execute_script "Bootsy.areas.post_content.editor.setValue('#{embed}')"
end

Then(/^I( don't)? see a link with the option "(.*?)" in the editor toolbar$/) do |negate, option|
  expectation = negate ? :not_to : :to

  expect(find('ul.wysihtml5-toolbar')).send(expectation, have_link(option))
end

Then(/^I see the video iframe properly rendered$/) do
  expected_embed = '<iframe src="//www.youtube.com/embed/d2QdITRRMHg" allowfullscreen="" frameborder="0" height="315" width="560"></iframe>'
  content =  page.evaluate_script('Bootsy.areas.post_content.editor.getValue()')

  expect(content).to include(expected_embed)
end
