require 'rubygems'
require 'cucumber'
require 'cucumber/rake/task'
require 'rspec/core/rake_task'

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "--format pretty" # Any valid command line option can go here.
end

RSpec::Core::RakeTask.new(:spec)

task :default => :test

task :test => [:spec, :features]

task :console do
  ruby "bin/run.rb"
end
