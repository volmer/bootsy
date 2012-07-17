module Bootsy
  class Engine < Rails::Engine

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

    config.after_initialize do
      puts 'volmer'
      puts BOOTSY_ORM
      case BOOTSY_ORM
      when :activerecord
        Dir[File.expand_path('../activerecord/*.rb', __FILE__)].each {|f| require f }
      end
    end
  end
end
