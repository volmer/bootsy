module Bootsy
  # Public: Methods and attributes to turn any
  # model into a Bootsy Container.
  #
  # Examples
  #
  #   class Post < ActiveRecord::Base
  #     include Bootsy::Container
  #   end
  module Container
    extend ActiveSupport::Concern

    included do
      has_one :bootsy_image_gallery,
              class_name: 'Bootsy::ImageGallery',
              as: :bootsy_resource,
              dependent: :destroy
    end

    # Public: Get the `id` attribute of the image gallery.
    #
    # Returns an Integer id or nil when there is
    # not an image gallery.
    def bootsy_image_gallery_id
      bootsy_image_gallery.try(:id)
    end

    # Public: Set the image gallery `id` and save
    # the association between models.
    #
    # Examples
    #
    #   container.id
    #   # => 34
    #   gallery.id
    #   # => 12
    #   container.bootsy_image_gallery_id = gallery.id
    #   container.image_gallery_id
    #   # => 12
    #   gallery.bootsy_resource.id
    #   # => 34
    def bootsy_image_gallery_id=(value)
      if bootsy_image_gallery.nil? && value.present?
        self.bootsy_image_gallery = Bootsy::ImageGallery.find(value)
        bootsy_image_gallery.bootsy_resource = self
        bootsy_image_gallery.save
      else
        value
      end
    end
  end
end
