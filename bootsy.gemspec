$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "bootsy/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "bootsy"
  s.version     = Bootsy::VERSION
  s.authors     = ["Volmer Soares"]
  s.email       = ["volmer@radicaos.com"]
  s.homepage    = "http://github.com/volmer/bootsy"
  s.summary     = "A beautiful wysiwig editor with image uploads for Rails."
  s.description = "Bootsy is a WYSIWIG editor for Rails applications based on WYSIHTML5 and Twitter Bootstrap. It integrates images uploads using Carrierwave, as an image gallery scoped in models of your application."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 3.2.6"
  s.add_dependency "jquery-rails"
  s.add_dependency "mini_magick"
  s.add_dependency "carrierwave"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "shoulda-matchers", "~>1.0"#, "~> 3.0"
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency "database_cleaner"
end
