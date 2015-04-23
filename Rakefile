require "bundler/gem_tasks"

# minitest, will be done by flavor-gem test
require "rake/testtask"
Rake::TestTask.new do |t|
  t.libs << "test"
  t.pattern = "test/**/test_*.rb"
end
task :default => :test

# to load library from local path
lib = File.expand_path("../../lib", __FILE__)
$LOAD_PATH.unshift lib unless $LOAD_PATH.include?(lib)
require "flavor_gem/gem_tasks"
