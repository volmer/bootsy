When(/^I set "(.*?)" to "(.*?)" on the editor options of bootsy_area$/) do |option, value|
  Bootsy.stub(editor_options: { option => value })
end

Then(/^I( don't)? see a link with the option "(.*?)" in the editor toolbar$/) do |negate, option|
  expectation = negate ? :not_to : :to

  expect(find('ul.wysihtml5-toolbar')).send(expectation, have_link(option))
end
