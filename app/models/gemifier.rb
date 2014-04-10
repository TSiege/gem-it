require 'tmpdir'

class Gemifier < ActiveRecord::Base

  def scaffold(name, creator, url, node_path, email)
    # Store gem directory names in variables
    gem_name = name
    gem_const = gem_name.split("_").collect(&:titleize).join()
    bin_name = "#{gem_name}/bin"
    gem_lib_dir = "#{gem_name}/lib"
    gem_lib_gem_dir = "#{gem_lib_dir}/#{gem_name}"

    # Create gem directory and nested lib directory
    Dir.mkdir(gem_name)
    Dir.mkdir(gem_lib_dir)
    Dir.mkdir(gem_lib_gem_dir)
    Dir.mkdir(bin_name, 0777)

    # Create lib/gem_name/info.rb ruby
info_name = File.join(gem_lib_gem_dir, 'info.rb')
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

    # Create lib/gem_name/gem_name.rb ruby
    module_name = File.join(gem_lib_gem_dir, "#{gem_name}.rb")
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
      result = doc.css('#{node_path}').text
      Info.new(result)
    end
  end

end

    EOT
    module_file.close

    # Create bin/gem_name ruby
bin_name = File.join(bin_name, name)
bin = File.new(bin_name, "w")
bin.puts(<<-EOT)
#!/usr/bin/env ruby

require '#{name}'

data = #{gem_const}::Magic.new("#{url}").call

puts data.data

    EOT
    bin.close

    # Create .gitignore
    gitignore_name = File.join(gem_name, '.gitignore')
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
#{name}/tmp
#{name}/version_tmp
tmp

    EOT
    gitignore.close

    # Create Gemfile
    gemfile_name = File.join(gem_name, 'Gemfile')
    gemfile = File.new(gemfile_name, "w")
    gemfile.puts(<<-EOT)
source 'https://rubygems.org'

# Specify your gem's dependencies in #{gem_const}.gemspec
gemspec

    EOT
    gemfile.close

    # Create License.txt
    license_name = File.join(gem_name, 'License.txt')
    license = File.new(license_name, "w")
    license.puts(<<-EOT)
source 'https://rubygems.org'

Copyright (c) 2014 #{creator}

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

    # Create Rakefile
    rakefile_name = File.join(gem_name, 'Rakefile')
    rakefile = File.new(rakefile_name, "w")
    rakefile.puts(<<-EOT)
require "bundler/gem_tasks"

    EOT
    rakefile.close

    # Create README.md
    readme_name = File.join(gem_name, 'README.md')
    readme = File.new(readme_name, "w")
    readme.puts(<<-EOT)
# #{name}Gem

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

    # Create #{gem_name}.gemspec
    gemspec_name = File.join(gem_name, "#{gem_name}.gemspec")
    gemspec = File.new(gemspec_name, "w")
    gemspec.puts(<<-EOT)
# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require '#{gem_name}/version'

Gem::Specification.new do |spec|
  spec.name          = "#{gem_name}"
  spec.version       = #{gem_const}::VERSION
  spec.authors       = ["#{creator}"]
  spec.email         = ["#{email}"]
  spec.summary       = "a generic scraper gem to use as a model"
  spec.description   = %q{I thought this was optional}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   << '#{gem_name}'
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "nokogiri"
end

    EOT
    gemspec.close

    # Create lib/gem.rb
    gem_file_name = File.join(gem_lib_dir, "#{gem_name}.rb")
    gem = File.new(gem_file_name, "w")
    gem.puts(<<-EOT)
require "open-uri"
require "nokogiri"
Dir[File.dirname(__FILE__) + '/#{name}/*.rb'].each do |file|
  require file
end
    EOT
    gem.close

    # Create lib/gem/version.rb
    version_name = File.join(gem_lib_gem_dir, 'version.rb')
    version = File.new(version_name, "w")
    version.puts(<<-EOT)
module #{gem_const}
  VERSION = "0.0.1"
end

    EOT
    version.close

    puts %x(pwd)
    Dir.chdir(gem_name)
    puts %x(pwd)
    puts %x(ls)
    %x(gem build #{gem_name}.gemspec)
    Dir.chdir('..')
    puts %x(pwd)
  end

end