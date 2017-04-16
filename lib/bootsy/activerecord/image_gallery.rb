# frozen_string_literal: true
module Bootsy
  # Public: A model that groups all images related to a
  # Bootsy container (also called a resource).
  #
  # It is important to note that the relation gallery - resource
  # is not mandatory due to the need of having galleries
  # related to unsaved containers. This may lead to creation
  # of orphan galleries. Because of that, this model includes
  # the `destroy_orphans` method, that removes all galleries
  # that do not point to resources older than the given time
  # limit.
  class ImageGallery < ActiveRecord::Base
    belongs_to :bootsy_resource, polymorphic: true, autosave: false,
                                 optional: true
    has_many :images, dependent: :destroy

    scope :destroy_orphans, lambda { |time_limit|
      where(
        'created_at < ? AND bootsy_resource_id IS NULL',
        time_limit
      ).destroy_all
    }
    def self.destroy_orphans(time_limit)
      Bootsy::ImageGallery.where('created_at < ? AND bootsy_resource_id IS NULL', time_limit).delete_all
      Bootsy::Image.where('image_gallery_id IS NULL AND created_at < ?',time_limit).delete_all
    end
    
  end
end
