# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pinchito/version'

Gem::Specification.new do |spec|
  spec.name          = "pinchito"
  spec.version       = Pinchito::VERSION
  spec.authors       = ["Bernat Rafales"]
  spec.email         = ["brafales@gmail.com"]
  spec.summary       = %q{Logs casolans a foc lent.}
  spec.homepage      = "http://www.thinkingeek.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest"

  spec.add_dependency "nokogiri"
  spec.add_dependency "faraday"
end
