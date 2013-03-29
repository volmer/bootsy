$:.push File.expand_path('../lib', __FILE__)

require 'bootsy/version'

Gem::Specification.new do |s|
  s.name        = 'bootsy'
  s.version     = Bootsy::VERSION
  s.authors     = ['Volmer Soares']
  s.email       = ['volmerius@gmail.com']
  s.homepage    = 'http://github.com/volmer/bootsy'
  s.summary     = 'A beautiful WYSIWYG editor with image uploads for Rails.'
  s.description = 'A beautiful WYSIWYG editor with image uploads for Rails.'

  s.files = Dir['{app,config,db,lib}/**/*'] + ['MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'mini_magick', '~> 3.5.0'
  s.add_dependency 'carrierwave', '~> 0.8.0'
  s.add_dependency 'remotipart', '~> 1.0.5'

  s.add_development_dependency 'rspec-rails', '~> 2.13'
  s.add_development_dependency 'factory_girl_rails', '~> 4.2'
  s.add_development_dependency 'database_cleaner', '~> 0.9'
  s.add_development_dependency 'cucumber-rails', '~> 1.3'
end
