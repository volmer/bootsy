# frozen_string_literal: true
# Bootsy Module
module Bootsy
  # Options for bootsy_resource for Rails 4 backwards compatibility
  def self.bootsy_resource_options
    { polymorphic: true, autosave: false }.tap do |options|
      options[:optional] = true if Rails::VERSION::MAJOR >= 5
    end
  end

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
    belongs_to :bootsy_resource, Bootsy.bootsy_resource_options
    has_many :images, dependent: :destroy

    def self.destroy_orphans(time_limit)
      where(
        'created_at < ? AND bootsy_resource_id IS NULL',
        time_limit
      ).destroy_all
    end
  end
end
