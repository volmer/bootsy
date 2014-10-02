module Bootsy
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      def add_routes
        route "mount Bootsy::Engine => '/bootsy', as: 'bootsy'"
      end

      def copy_locale
        copy_file '../../../../config/locales/bootsy.en.yml', 'config/locales/bootsy.en.yml'
      end

      def add_assets
        [
          {
            original: 'app/assets/javascripts/application.js',
            skip_if: 'require bootsy',
            content: "\n//= require bootsy",
            position: {
              after: '//= require jquery_ujs'
            }
          },
          {
            original: 'app/assets/stylesheets/application.css',
            skip_if: 'require bootsy',
            content: "\n *= require bootsy",
            position: {
              after: '*= require_self'
            }
          }
        ].each do |params|
          if File.exists?(params[:original])
            if File.binread(params[:original]).include?(params[:skip_if])
              say_status('skipped', "insert into #{params[:original]}", :yellow)
            else
              insert_into_file(params[:original], params[:content], params[:position])
            end
          else
            say_status('not found', "#{params[:original]} not found. You must manually require Bootsy in your assets pipeline.", :red)
          end
        end
      end

      def copy_config
        template 'bootsy.rb', 'config/initializers/bootsy.rb'
      end
    end
  end
end
