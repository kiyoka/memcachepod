require 'rake'
require 'bundler/setup'
require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = Dir.glob('spec/**/*_spec.rb')
  t.rspec_opts = '--format documentation'
# t.rcov = true
end
task :default => :spec

# 'gem install rdoc' to upgrade RDoc if this is giving you errors
require 'rdoc/task'
RDoc::Task.new do |rd|
  rd.rdoc_files.include("lib/**/*.rb")
end
