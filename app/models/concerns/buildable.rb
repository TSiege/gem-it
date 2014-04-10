module Buildable
  
  module ClassMethods

  end

  module InstanceMethods 

    def build_info_rb
      info_name = File.join(self.gemfiles_dir, 'info.rb')
      info = File.new(info_name, "w")
      info.puts(<<-EOT)

class Info

  attr_accessor :data
  def initialize(data)
    @data = data
  end

end

    EOT

    info.close
    end

    def build_model_rb
      module_name = File.join(self.gemfiles_dir, "#{self.gem_name}.rb")
      module_file = File.new(module_name, "w")
      module_file.puts(<<-EOT)

module #{gem_const}
  
  class Magic

    attr_accessor :source  

    def initialize(source) 
      @source = source
    end

    def call
      doc = Nokogiri::HTML(open(self.source))
      result = doc.xpath('#{self.node_path}').text
      if result.empty?
        result = doc.xpath('#{self.node_path_fallback}').text
      end
      Info.new(result)
    end
  end

end

    EOT
    module_file.close
    end

    def build_runner 
      bin_name = File.join(self.bin_dir, self.gem_name)
      bin = File.new(bin_name, "w")
      bin.puts(<<-EOT)

#!/usr/bin/env ruby

require '#{self.gem_name}'

data = #{self.gem_const}::Magic.new("#{self.website}").call

puts data.data

      EOT
      bin.close

    end

    def build_gitignore
      # Create .gitignore
      gitignore_name = File.join(self.gem_name, '.gitignore')
      gitignore = File.new(gitignore_name, "w")
      gitignore.puts(<<-EOT)

*.gem
*.rbc
.bundle
.config
.yardoc
Gemfile.lock
InstalledFiles
_yardoc
coverage
doc/
lib/bundler/man
pkg
rdoc
spec/reports
#{self.gem_name}/tmp
#{self.gem_name}/version_tmp
tmp

      EOT
      gitignore.close

    end

    def build_gemfile
      # Create Gemfile
      gemfile_name = File.join(self.gem_name, 'Gemfile')
      gemfile = File.new(gemfile_name, "w")
      gemfile.puts(<<-EOT)

source 'https://rubygems.org'

# Specify your gem's dependencies in #{self.gem_const}.gemspec
gemspec

      EOT
      gemfile.close

    end

    def build_license 
      # Create License.txt
      license_name = File.join(self.gem_name, 'License.txt')
      license = File.new(license_name, "w")
      license.puts(<<-EOT)

source 'https://rubygems.org'

Copyright (c) 2014 #{self.author}

MIT License

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

      EOT
      license.close


    end

    def build_rakefile
      # Create Rakefile
      rakefile_name = File.join(self.gem_name, 'Rakefile')
      rakefile = File.new(rakefile_name, "w")
      rakefile.puts(<<-EOT)

require "bundler/gem_tasks"

      EOT
      rakefile.close

    end

    def build_readme
      # Create README.md
      readme_name = File.join(self.gem_name, 'README.md')
      readme = File.new(readme_name, "w")
      readme.puts(<<-EOT)

# #{self.gem_name}Gem

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'gem'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gem

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it ( http://github.com/<my-github-username>/gem/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

      EOT
      readme.close
    end

    def build_gemspec 
      # Create #{gem_name}.gemspec
      gemspec_name = File.join(self.gem_name, "#{self.gem_name}.gemspec")
      gemspec = File.new(gemspec_name, "w")
      gemspec.puts(<<-EOT)

# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require '#{self.gem_name}/version'

Gem::Specification.new do |spec|
  spec.name          = "#{self.gem_name}"
  spec.version       = #{self.gem_const}::VERSION
  spec.authors       = ["#{self.author}"]
  spec.email         = ["#{self.author_email}"]
  spec.summary       = "a generic scraper gem to use as a model"
  spec.description   = %q{I thought this was optional}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   << '#{self.gem_name}'
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "nokogiri"
end

      EOT
      gemspec.close

    end

    def build_env
      # Create lib/gem.rb
      gem_file_name = File.join(self.lib_dir, "#{self.gem_name}.rb")
      gem = File.new(gem_file_name, "w")
      gem.puts(<<-EOT)

require "open-uri"
require "nokogiri"
Dir[File.dirname(__FILE__) + '/#{self.gem_name}/*.rb'].each do |file|
  require file
end

      EOT
      gem.close
    end  

    def build_version
      # Create lib/gem/version.rb
      version_name = File.join(self.gemfiles_dir, 'version.rb')
      version = File.new(version_name, "w")
      version.puts(<<-EOT)

module #{self.gem_const}
  VERSION = "0.0.1"
end

      EOT
      version.close

    end
  end
end