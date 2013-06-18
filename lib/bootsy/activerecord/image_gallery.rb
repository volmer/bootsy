module Bootsy
  class ImageGallery < ActiveRecord::Base
    belongs_to :bootsy_resource, polymorphic: true
    has_many :images, dependent: :destroy

    scope :destroy_orphans, ->(time_limit) { where('created_at < ? AND bootsy_resource_id IS NULL', time_limit).destroy_all }
  end
end
