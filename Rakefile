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

require "cucumber/rake/task"
require 'rspec/core/rake_task'

task :default => [:spec,:run]

RSpec::Core::RakeTask.new(:spec)

Cucumber::Rake::Task.new(:run) do |t|
  t.cucumber_opts = ["-t","~@pending","features --format pretty","-s"]
end

Cucumber::Rake::Task.new(:wip) do |t|
  t.cucumber_opts = ["-t","@wip","features"]
end