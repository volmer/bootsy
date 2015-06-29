#!/usr/bin/env rake
begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end
begin
  require 'rdoc/task'
rescue LoadError
  require 'rdoc/rdoc'
  require 'rake/rdoctask'
  RDoc::Task = Rake::RDocTask
end

RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Bootsy'
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

Bundler::GemHelper.install_tasks

require 'rspec/core/rake_task'
require 'coveralls/rake/task'
require 'rubocop/rake_task'

RuboCop::RakeTask.new(:rubocop) do |task|
  task.patterns = ['app/**/*.rb', 'lib/**/*.rb']
end
Coveralls::RakeTask.new
RSpec::Core::RakeTask.new(:spec)

task default: [:rubocop, :spec, 'coveralls:push']
