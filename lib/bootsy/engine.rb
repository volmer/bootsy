module Bootsy
  # Public: Define and setup Bootsy as a Rails engine.
  class Engine < Rails::Engine
    isolate_namespace Bootsy

    config.generators do |g|
      g.test_framework :rspec
      g.integration_tool :rspec
    end
  end
end
