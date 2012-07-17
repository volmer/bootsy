$:.push File.expand_path("../lib", __FILE__)

require "bootsy/version"

Gem::Specification.new do |s|
  s.name        = "bootsy"
  s.version     = Bootsy::VERSION
  s.authors     = ["Volmer Soares"]
  s.email       = ["lrvolmer@gmail.com"]
  s.homepage    = "http://github.com/volmer/bootsy"
  s.summary     = "A beautiful wysiwig editor with image uploads for Rails."
  s.description = "Bootsy is a WYSIWIG editor for Rails applications based on WYSIHTML5 and Twitter Bootstrap. It integrates images uploads using CarrierWave, as an image gallery scoped in models of your application."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "mini_magick"
  s.add_dependency "carrierwave"
  s.add_dependency "remotipart"

  s.add_development_dependency "rails", "~> 3.2.6"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "cucumber-rails"
end
