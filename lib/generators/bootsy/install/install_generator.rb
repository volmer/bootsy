module Bootsy
  module Generators
    class InstallGenerator < Rails::Generators::Base
      #include Rails::Generators::ResourceHelpers
      source_root File.expand_path('../templates', __FILE__)

      def add_routes
        route "mount Bootsy::Engine => '/bootsy', as: 'bootsy'"
      end

      def copy_locale
        copy_file "../../config/locales/en.yml", "config/locales/bootsy.en.yml"
      end

      def add_assets
        #insert_into_file "app/assets/javascripts/application.js", "//= require bootsy/application\n", after: "jquery_ujs\n"
        #insert_into_file "app/assets/stylesheets/application.css", "*= require bootsy/application\n", after: "require_self\n"
      end
    end
  end
end