module Bootsy
  # Public: Define and setup Bootsy as a Rails engine.
  class Engine < Rails::Engine
    isolate_namespace Bootsy

    config.generators do |g|
      g.test_framework :rspec
      g.integration_tool :rspec
    end

    config.to_prepare do
      ActionController::Base.helper(Bootsy::ApplicationHelper)
      # Included at ApplicationController to prevent
      # missing helpers when it is eager loaded.
      ApplicationController.helper(Bootsy::ApplicationHelper)
    end

    config.after_initialize do
      if defined?(BOOTSY_ORM)
        orm = BOOTSY_ORM
      else
        orm = :activerecord
      end

      # Require Active Record models. Other ORMs must
      # include their own Bootsy models.
      if orm == :activerecord
        Dir[File.expand_path('../activerecord/*.rb', __FILE__)].each {|f| require f }
      end
    end
  end
end
