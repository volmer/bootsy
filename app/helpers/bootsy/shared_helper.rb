module Bootsy
  module SharedHelper
    def image_gallery resource
      render 'bootsy/images/index', {:resource => resource}
    end
  end
end
