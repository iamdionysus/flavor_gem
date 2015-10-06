# to load library from local path
lib = File.expand_path("../../lib", __FILE__)
$LOAD_PATH.unshift lib unless $LOAD_PATH.include?(lib)
require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList['test/**/*_test.rb']
end

task :default => :test

require "rspec/core/rake_task"
RSpec::Core::RakeTask.new :spec

