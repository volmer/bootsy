module Bootsy
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root __FILE__

      def add_routes
        route "mount Bootsy::Engine => '/bootsy', as: 'bootsy'"
      end

      def copy_locale
        copy_file "../../../../config/locales/en.yml", "config/locales/bootsy.en.yml"
      end

      def add_assets

        [{original: 'app/assets/javascripts/application.js',
          skip_if: 'require bootsy', 
          content: "//= require bootsy\n", 
          position: {before: '//= require_tree .'}},
         {original: 'app/assets/stylesheets/application.css',
          skip_if: 'require bootsy', 
          content: "*= require bootsy\n", 
          position: {before: '*/'}}]. each do |params|

          if File.binread(params[:original]).include?(params[:skip_if])
            say_status 'skipped', "insert into #{params[:original]}", :yellow
          else
            insert_into_file params[:original], params[:content], params[:position]
          end
        end

      end

      def copy_config
        template '../templates/bootsy.rb', 'config/initializers/bootsy.rb'
      end

    end
  end
end