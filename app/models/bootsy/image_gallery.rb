module Bootsy
  class ImageGallery < ActiveRecord::Base
    belongs_to :bootsy_resource, polymorphic: true
    has_many :images, dependent: :destroy
  end
end
