module Bootsy
  module SharedHelper
    def image_gallery resource
      render 'bootsy/images/modal', {:resource => resource}
    end
  end
end
