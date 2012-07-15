Given /^I access its image gallery$/ do
  step 'I press "Insert image"'
  step 'I should see the image gallery'
end

When /^I attach the file "(.*?)" on "(.*?)"$/ do |file, field|
  attach_file "image[#{field}]", path_to_file(file)
end

Then /^I should see the thumbnail "(.*?)" on the image gallery$/ do |thumbnail|
  find('div#bootsy_image_gallery a.thumbnail img')[:src].should have_content("/thumb_#{thumbnail}")
end