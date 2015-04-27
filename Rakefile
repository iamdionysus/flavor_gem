# to load library from local path
lib = File.expand_path("../../lib", __FILE__)
$LOAD_PATH.unshift lib unless $LOAD_PATH.include?(lib)
require "bundler/gem_tasks"

task :default => :test

# added by flavor-gem generate minitest
require "flavor_gem/gem_tasks"
require "rake/testtask"

Rake::TestTask.new do |t|
  t.libs << "test"
  t.pattern = "test/**/test_*.rb"
end
