require 'active_support/concern'

module Bootsy
  module MediaContainer 

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
          self.bootsy_image_gallery = Bootsy::ImageGallery.find value unless value.blank?
        end
      end
    end
  end
end