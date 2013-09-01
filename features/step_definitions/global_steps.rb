Given /^I am on (.*?) page$/ do |page|
  visit path_to(page)
end

When /^I go to (.*?) page$/ do |page|
  step "I am on #{page} page"
end

Given 'I change the content of the text area' do
  page.execute_script "Bootsy.areas[0].editor.fire('change')"
end

Then /^I should see (.*?) page$/ do |page|
  #wait_until { current_path == path_to(page) }
  current_path.should == path_to(page)
end

When /^I press "(.*?)"$/ do |button|
  click_on button
end

When /^I press '(.*?)' within (.*?)$/ do |button, field_name|
  within ".field.#{field_name}" do
    click_on button
  end
end

When /^I click on "(.*?)"$/ do |link_name|
  click_link link_name
end

When 'I accept the alert prompt' do
  page.driver.browser.switch_to.alert.accept
end

When 'I dismiss the alert prompt' do
  page.driver.browser.switch_to.alert.dismiss
end
