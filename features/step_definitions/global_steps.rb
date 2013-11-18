Given(/^I am on (.*?) page$/) do |page|
  visit path_to(page)
end

When(/^I go to (.*?) page$/) do |page|
  step "I am on #{page} page"
end

Then(/^I am redirected to (.*?) page$/) do |page|
  expect(current_path).to eq path_to(page)
end

Then(/^I'm still on (.*?) page$/) do |page|
  expect(current_path).to eq path_to(page)
end

When(/^I press "(.*?)"$/) do |button|
  click_on button
end

When(/^I click on "(.*?)"$/) do |link_name|
  click_link link_name
end

When('I accept the alert prompt') do
  page.driver.browser.switch_to.alert.accept
end

When('I dismiss the alert prompt') do
  page.driver.browser.switch_to.alert.dismiss
end

When(/^I fill in "(.*?)" with "(.*?)"$/) do |field, value|
  fill_in field, with: value
end

Then(/^I see "(.*?)" on the page$/) do |content|
  expect(page).to have_content(content)
end
