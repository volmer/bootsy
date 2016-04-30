require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

RuboCop::RakeTask.new(:rubocop) do |task|
  task.patterns = ['app/**/*.rb', 'lib/**/*.rb']
end
RSpec::Core::RakeTask.new(:spec)

task default: [:rubocop, :spec]
