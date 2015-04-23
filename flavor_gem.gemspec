# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'flavor_gem/version'

Gem::Specification.new do |spec|
  spec.name          = "flavor_gem"
  spec.version       = FlavorGem::VERSION
  spec.authors       = ["iamdionysus"]
  spec.email         = ["iamdionysus@gmail.com"]

  spec.summary       = spec.description
  spec.description   = "Flavors bundler gem skeleton with thor and rails minitest style test macro"
  spec.homepage      = "http://github.com/iamdionysus/flavor_gem"

  spec.files         = %w[flavor_gem.gemspec] + Dir['*.md', 'bin/*', 'lib/**/*.rb']
  spec.bindir        = "bin"
  spec.executables   = %w[flavor-gem]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
end
