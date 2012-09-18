# Use this setup block to configure all options available in Bootsy.
Bootsy.setup do |config|

  # Image versions available
  # Possible values: :small, :medium, :large and/or :original
  config.image_versions_available = [:small, :medium, :large, :original]


  # SMALL IMAGES

  # Width limit for small images
  # config.small_image[:width] = 160

  # Height limit for small images
  # config.small_image[:height] = 160


  # MEDIUM IMAGES

  # Width limit for medium images
  # config.medium_image[:width] = 360

  # Height limit for medium images
  # config.medium_image[:height] = 360


  # LARGE IMAGES

  # Width limit for large images
  # config.large_image[:width] = 760

  # Height limit for large images
  # config.large_image[:height] = 760


  # Store directory (inside of 'public')
  # config.store_dir = 'uploads'


  # Whether user can destroy uploaded files
  # config.allow_destroy = true
end