include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :image, class: Bootsy::Image do
    image_file { fixture_file_upload(Rails.root.to_s + '/public/test.jpg', 'image/jpeg') }
    image_gallery
  end
end
