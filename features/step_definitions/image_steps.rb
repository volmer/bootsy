Given 'I access its image gallery' do
  step 'I press "Insert image"'
  step 'I should see the image gallery'
end

When /^I attach the file "(.*?)" on "(.*?)"$/ do |file, field|
  attach_file "image[#{field}]", path_to_file(file)
end

Then /^I should( not)? see the thumbnail "(.*?)" on the image gallery$/ do |negate, thumbnail|
  expectation = negate ? :should_not : :should

  page.send expectation, have_selector(:xpath, "//div[@id='bootsy_image_gallery']//img[contains(@src,'/thumb_#{thumbnail}')]", visible: true)
end

Given /^I upload the image "(.*?)"$/ do |image_file|
  step "I attach the file \"#{image_file}\" on \"image_file\""
  step "I should see the thumbnail \"#{image_file}\" on the image gallery"
end

When /^I click on the image "(.*?)"$/ do |image_name|
  find(:xpath, "//div[@id='bootsy_image_gallery']//img[contains(@src,'/thumb_#{image_name}')]").click
end

When /^I click on the "(.*?)" option of the submenu$/ do |position|
  find('li.dropdown-submenu ul.dropdown-menu li a', visible: true, text: /#{position}/).click
end

When /^I open the "(.*?)" menu$/ do |term|
  page.execute_script("$('a:contains(#{term}):visible').parent().find('.dropdown-menu').show()")
end

When(/^I insert the image "(.*?)" on the text$/) do |image|
  step 'I click on the image "test.jpg"'
  step 'I open the "Small" menu'
  step 'I click on the "Left" option of the submenu'
end

Then /^I should see the image "(.*?)" in its (.*?) size inserted on the text area positioned as (.*?)$/ do |image_file, size, position|
  size.downcase!
  img_src = "/#{size}_#{image_file}"
  img_src = "/#{image_file}" if size == 'original'

  content =  page.evaluate_script('Bootsy.areas[0].editor.getValue()')

  content.should include(img_src)
  content.should include("align=\"#{position.downcase}\"")
end

Then(/^I see the post created with the image "(.*?)" in it$/) do |image|
  expect(page).to have_selector(:xpath, "//div[@id='posts']//img[contains(@src,'/small_#{image}')]")
end
