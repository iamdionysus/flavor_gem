# to load library from local path
lib = File.expand_path("../../lib", __FILE__)
$LOAD_PATH.unshift lib unless $LOAD_PATH.include?(lib)
require "bundler/gem_tasks"
require "flavor_gem/bump_tasks"

task :default => :test

# added by flavor-gem generate minitest
require "rake/testtask"
                   
Rake::TestTask.new do |t|
  t.libs << "test"
  t.pattern = "test/**/test_*.rb"
end
