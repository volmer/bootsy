Given 'I access its image gallery' do
  step 'I press "Insert image"'
  step 'I should see the image gallery'
end

When /^I attach the file "(.*?)" on "(.*?)"$/ do |file, field|
  attach_file "image[#{field}]", path_to_file(file)
end

Then /^I should( not)? see the thumbnail "(.*?)" on the image gallery$/ do |negate, thumbnail|
  wait_until { find("ul.thumbnails").visible? }
  expectation = negate ? :should_not : :should

  page.send expectation, have_selector('div#bootsy_image_gallery a.thumbnail img', src: "/thumb_#{thumbnail}", visible: true)
end

Given /^I upload the image "(.*?)"$/ do |image_file|
  step "I attach the file \"#{image_file}\" on \"image_file\""
  step 'I press "Load"'
  step "I should see the thumbnail \"#{image_file}\" on the image gallery"
end

When /^I click on the image "(.*?)"$/ do |image_name|
  find('div#bootsy_image_gallery a.thumbnail img', src: "/thumb_#{image_name}").click
end

When /^I open the "(.*?)" menu$/ do |term|
  page.execute_script("$('a:contains(#{term}):visible').parent().find('.dropdown-menu').show()")
end

Then /^I should see the image "(.*?)" in its (.*?) size inserted on the text area positioned as (.*?)$/ do |image_file, size, position|
  size.downcase!
  img_src = "/#{size}_#{image_file}"
  img_src = "/#{image_file}" if size == 'original'

  content =  page.evaluate_script('Bootsy.editor.getValue()')
  #wait_until { !find('textarea.bootsy_text_area').value.blank? }
  #content = find('textarea.bootsy_text_area').value

  content.should include(img_src)
  content.should include("align=\"#{position.downcase}\"")
end