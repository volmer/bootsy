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

  s.add_dependency 'mini_magick', '~> 3.7.0'
  s.add_dependency 'carrierwave', '~> 0.9.0'
  s.add_dependency 'remotipart', '~> 1.2.1'
end
