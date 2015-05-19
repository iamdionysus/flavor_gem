# to load library from local path
lib = File.expand_path("../../lib", __FILE__)
$LOAD_PATH.unshift lib unless $LOAD_PATH.include?(lib)
require "bundler/gem_tasks"

require "rspec/core/rake_task"
RSpec::Core::RakeTask.new :spec

task default: :spec
