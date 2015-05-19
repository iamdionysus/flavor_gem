# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "flavor_gem/version"

Gem::Specification.new do |spec|
  spec.name          = "flavor_gem"
  spec.version       = FlavorGem::VERSION
  spec.authors       = %w(iamdionysus)
  spec.email         = %w(iamdionysus@gmail.com)

  spec.summary       = spec.description
  spec.description   = "Flavors bundler generated Rubygem and scaffolding"
  spec.homepage      = "http://github.com/iamdionysus/flavor_gem"

  spec.files         = %w(flavor_gem.gemspec) + Dir["*.md", "bin/*", "lib/**/*.rb"]
  spec.bindir        = "bin"
  spec.executables   = %w(flavor-gem)
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"

  # should be added by flavor-gem generate thor
  spec.add_runtime_dependency "thor", "~> 0.19"
end
