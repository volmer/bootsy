module Bootsy
  module Generators
    # Public: A Rails Generator to copy translations, assets and routes to
    # the host app.
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      def add_routes
        route "mount Bootsy::Engine => '/bootsy', as: 'bootsy'"
      end

      def copy_locale
        copy_file '../../../../config/locales/bootsy.en.yml',
                  'config/locales/bootsy.en.yml'
      end

      def add_javascript
        require_asset(
          'app/assets/javascripts/application.js',
          "\n//= require bootsy",
          '//= require jquery_ujs'
        )
      end

      def add_stylesheet
        require_asset(
          'app/assets/stylesheets/application.css',
          "\n *= require bootsy",
          '*= require_self'
        )
      end

      def copy_config
        template 'bootsy.rb', 'config/initializers/bootsy.rb'
      end

      private

      def require_asset(destination, content, after_line)
        if File.exist?(destination)
          if File.binread(destination).include?(content)
            say_status('skipped', "insert into #{destination}", :yellow)
          else
            insert_into_file(destination, content, after: after_line)
          end
        else
          say_status('not found', "#{destination} not found. You must
            manually require Bootsy in your assets pipeline.", :red)
        end
      end
    end
  end
end
