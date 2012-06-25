module Bootsy
  class Engine < ::Rails::Engine
    isolate_namespace Bootsy

    config.generators do |g|                                                               
      g.test_framework :rspec
      g.integration_tool :rspec
    end

    config.to_prepare do
      ActionController::Base.class_eval do
        helper Bootsy::SharedHelper
      end

      ActiveRecord::Base.class_eval do
        has_many :images, :class_name => 'Bootsy::Image', :as => :bootsy_imageable
      end

    end
  end
end
