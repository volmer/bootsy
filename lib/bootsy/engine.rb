module Bootsy
  class Engine < ::Rails::Engine
    isolate_namespace Bootsy

    config.generators do |g|                                                               
      g.test_framework :rspec
      g.integration_tool :rspec
    end

    config.to_prepare do
      ActionController::Base.class_eval do
        helper Bootsy::ApplicationHelper
      end
    end
  end
end
