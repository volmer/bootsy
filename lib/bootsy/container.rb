require 'active_support/concern'

module Bootsy
  module Container 

    extend ActiveSupport::Concern
    
    included do
      class_eval do
        has_one :bootsy_image_gallery, :class_name => 'Bootsy::ImageGallery', as: :bootsy_resource, dependent: :destroy
        attr_accessible :bootsy_image_gallery_id

        def bootsy_image_gallery_id
          if self.bootsy_image_gallery.nil?
            return nil
          else
            return self.bootsy_image_gallery.id
          end
        end

        def bootsy_image_gallery_id=(value)
          if self.bootsy_image_gallery.nil? && !value.blank?
            ig = Bootsy::ImageGallery.find value
            self.bootsy_image_gallery = ig
            ig.bootsy_resource = self
            ig.save
          end
        end
      end
    end
  end
end