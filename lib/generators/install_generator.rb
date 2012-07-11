module Bootsy
  module Generators
    class InstallGenerator < Rails::Generators::Base

      desc "Copy Bootsy config and locale files to your application."


      def add_routes
        insert_into_file "config/routes.rb", "  mount Bootsy::Engine => '/bootsy', as: 'bootsy'\n", after: "Rails.application.routes.draw do\n"
      end


      def copy_config
        copy_file "../../config/bootsy.yml", "config/bootsy.yml"
      end

      def copy_locale
        copy_file "../../config/locales/en.yml", "config/locales/bootsy.en.yml"
      end

      def add_assets
        insert_into_file "app/assets/javascripts/application.js", "//= require bootsy\n", after: "jquery_ujs\n"
        insert_into_file "app/assets/stylesheets/application.css", "*= require bootsy\n", after: "require_self\n"
      end
    end
  end
end