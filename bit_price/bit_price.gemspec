# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bit_price/version'

Gem::Specification.new do |spec|
  spec.name          = "bit_price"
  spec.version       = BitPrice::VERSION
  spec.authors       = ["George"]
  spec.email         = ["george@email.com"]
  spec.summary       = "a generic scraper gem to use as a model"
  spec.description   = %q{I thought this was optional}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split(" ")
  spec.executables   << 'bit_price'
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "nokogiri"
end

