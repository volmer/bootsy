require 'carrierwave'
require 'bootsy/engine'
require 'bootsy/form_helper'
require 'bootsy/form_builder'
require 'bootsy/core_ext'

autoload :BootsyInput, 'bootsy/simple_form/bootsy_input'

# Public: Top Bootsy module
module Bootsy
  ## CONFIGURATION OPTIONS

  # Storage mode
  mattr_accessor :storage
  @@storage = :file

  # Store directory (inside 'public')
  mattr_accessor :store_dir
  @@store_dir = 'uploads'

  # Specify which controller to inherit from
  mattr_accessor :base_controller
  @@base_controller = ActionController::Base

  # Uploader that will store attachments. If you want to process images, you can
  # Limit dimensions (width, height) for uploaded images.
  mattr_accessor :image_limit
  @@image_limit = [1280, 720]

  # Default way to setup Bootsy. Run rails generate bootsy:install
  # to create a fresh initializer with all configuration values.
  def self.setup
    yield self
  end
end
