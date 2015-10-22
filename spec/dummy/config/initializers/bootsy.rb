# Use this setup block to configure all options available in Bootsy.
Bootsy.setup do |config|
  # Limit dimensions (width, height) for uploaded images.
  # config.image_limit = [1280, 720]
  #
  # Storage mode
  #   You can change the sorage mode below from :file to :fog if you want
  #   to use Amazon S3 and other cloud services. If you do that, please add
  #   'fog' to your Gemfile and create and configure your credentials in an
  #   initializer file, as described in Carrierwave's docs:
  #   https://github.com/carrierwaveuploader/carrierwave#using-amazon-s3
  # config.storage = :file
  #
  # Store directory (inside 'public') for storage = :file
  #   BE CAREFUL! Changing this may break previously uploaded file paths!
  # config.store_dir = 'uploads'
  #
  # Specify the controller to inherit from. Using ApplicationController
  # allows you to perform authentication from within your app.
  # config.base_controller = ActionController::Base
end
