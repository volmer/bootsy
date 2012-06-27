require 'active_support/concern'

module Bootsy::MediaContainer 

  extend ActiveSupport::Concern
  
  included do
    class_eval do
      has_many :bootsy_images, :class_name => 'Bootsy::Image', :as => :bootsy_imageable, :dependent => :destroy
    end
  end
end