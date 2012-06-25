require 'active_support/concern'

module Bootsy::Imageable 

  extend ActiveSupport::Concern
  
  included do
    class_eval do
      has_many :bootsy_images, :class_name => 'Bootsy::Image', :as => :bootsy_imageable
    end
  end
end