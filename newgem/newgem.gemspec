
# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'newgem/version'

Gem::Specification.new do |spec|
  spec.name          = "newgem"
  spec.version       = Newgem::VERSION
  spec.authors       = ["george"]
  spec.email         = ["email.com"]
  spec.summary       = "description"
  spec.description   = %q{I thought this was optional}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = Dir['{bin/*,lib/**/*}'] +
                        %w(newgem.gemspec Rakefile README.md) 
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake", "~> 2.2"
  spec.add_development_dependency "nokogiri", "~> 2.2"

end

