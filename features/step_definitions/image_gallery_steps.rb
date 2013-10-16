Given 'there is a post with images' do
  post = Post.new title: 'Test', content: 'test'
  post.bootsy_image_gallery_id = FactoryGirl.create(:image_gallery_with_images).id
  post.save!
end

Then 'I should see the image gallery' do
  page.should have_css('#bootsy_image_gallery', visible: true)
end

Then /^the image gallery should( not)? be empty$/ do |negate|
  expectation = negate ? :should : :should_not
  page.send expectation, have_css('#bootsy_image_gallery .bootsy-image', visible: true)
end
