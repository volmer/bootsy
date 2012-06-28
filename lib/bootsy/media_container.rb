require 'active_support/concern'

module Bootsy
  module MediaContainer 

    extend ActiveSupport::Concern
    
    included do
      class_eval do
        has_one :image_gallery, :class_name => 'Bootsy::ImageGallery', as: :bootsy_resource, dependent: :destroy
      end
    end
  end
end