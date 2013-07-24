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

require 'cucumber/rake/task'
require 'rspec/core/rake_task'
require 'coveralls/rake/task'

Coveralls::RakeTask.new

task default: [:spec, :cucumber, 'coveralls:push']

RSpec::Core::RakeTask.new(:spec)

Cucumber::Rake::Task.new do |t|
  # Uncomment this line when cucumber/multi_test work with minitest.
  # t.cucumber_opts = %w{--format pretty -s}
end
