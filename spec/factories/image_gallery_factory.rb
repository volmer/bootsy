# frozen_string_literal: true
FactoryGirl.define do
  factory :image_gallery, class: Bootsy::ImageGallery do
    factory :image_gallery_with_images do
      transient do
        images_count 3
      end

      after :create do |image_gallery, evaluator|
        FactoryGirl.create_list(
          :image, evaluator.images_count, image_gallery: image_gallery
        )
      end
    end
  end
end
