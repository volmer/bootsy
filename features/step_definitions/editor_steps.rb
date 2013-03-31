When /^I set "(.*?)" as "(.*?)" on the editor options of bootsy_area$/ do |option, value|
  Bootsy.editor_options = {option => value}
end

Then /^I should( not)? see a link with the option "(.*?)" in the editor toolbar$/ do |negate, option|
  expectation = negate ? :should_not : :should
  find('ul.wysihtml5-toolbar').send expectation, have_link(option)
end