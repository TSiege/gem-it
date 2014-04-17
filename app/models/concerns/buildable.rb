module Buildable
  
  module ClassMethods

  end

  module InstanceMethods 

    def build_info_rb
      info_name = File.join(self.gemfiles_dir, 'info.rb')
      info = File.new(info_name, "w")
      info.puts(<<-EOT)

module #{gem_const}

  class Info

    def initialize(data)
      data.each do |d|
        unless d.length == 0
          key, value = d.first
          method_name = key
          instance_variable_set("@" + method_name, value)
          define_singleton_method(key) {instance_variable_get("@" + key)} 
        end  
      end  
    end

  end

end  

    EOT

    info.close
    end

    def build_model_rb
      module_name = File.join(self.gemfiles_dir, "#{self.gem_file_name}.rb")
      module_file = File.new(module_name, "w")
      module_file.puts(<<-EOT)

module #{gem_const}
  
  class Magic

    attr_accessor :source, :doc  

    def initialize
      @source = "#{self.target_website}"
    end

    def call
      @doc = Nokogiri::HTML(open(self.source))
      
      result = #{self.method_names_and_node_paths}.collect do |v| 
        set_value(v)
      end
      
      #{self.gem_const}::Info.new(result)
    end

    private

    def set_value(hash)
      key, value = hash.first
      result = self.doc.xpath(value).text
      key = methodize(key)
      if result.empty?
        result = self.doc.xpath(strip_tbody(value)).text
      end
      {key => result}
    end

    def strip_tbody(value)
      value.gsub(/tbody\[.\]/,"") if !value.nil?
    end

    def methodize(string)
      string.downcase.gsub(" ", "_").strip 
    end
  end

end

    EOT
    module_file.close
    end

    def build_runner 
      bin_name = File.join(self.bin_dir, self.gem_file_name)
      bin = File.new(bin_name, "w")
      bin.puts(<<-EOT)

#!/usr/bin/env ruby

require '#{self.gem_file_name}'

data = #{self.gem_const}::Magic.new.call

data.instance_variables.each do |v|
  method = v.to_s.gsub("@", "")
  method_name = method.gsub("_", " ")
  puts method_name + ": " + data.send(method)
end

      EOT
      bin.close

    end

    def build_gitignore
      # Create .gitignore
      gitignore_name = File.join(@tmpdir, '.gitignore')
      gitignore = File.new(gitignore_name, "w")
      gitignore.puts(<<-EOT)

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
#{self.gem_file_name}/tmp
#{self.gem_file_name}/version_tmp
tmp

      EOT
      gitignore.close

    end

    def build_gemfile
      # Create Gemfile
      gemfile_name = File.join(@tmpdir, 'Gemfile')
      gemfile = File.new(gemfile_name, "w")
      gemfile.puts(<<-EOT)

source 'https://rubygems.org'

# Specify your gem's dependencies in #{self.gem_file_name}.gemspec
gemspec

      EOT
      gemfile.close

    end

    def build_license 
      # Create License.txt
      license_name = File.join(@tmpdir, 'License.txt')
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
      rakefile_name = File.join(@tmpdir, 'Rakefile')
      rakefile = File.new(rakefile_name, "w")
      rakefile.puts(<<-EOT)

require "bundler/gem_tasks"

      EOT
      rakefile.close

    end

    def build_readme
      # Create README.md
      readme_name = File.join(@tmpdir, 'README.md')
      readme = File.new(readme_name, "w")
      readme.puts(<<-EOT)

# #{self.gem_name}

#{self.description}

## Installation

Add this line to your application's Gemfile:

    gem '#{self.gem_file_name}'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install #{self.gem_file_name}

## Command Line Usage

Use #{self.gem_file_name} in your command line to print out the data whenever you want.

    $ #{self.gem_file_name}

## Ruby Usage

Require #{self.gem_file_name} in your app to return an object with the data included. 

    $ require '#{self.gem_file_name}'

Alternatively, require it directly from Github.

    $ gem '#{self.gem_file_name}', :git => '#{self.repo.git_url}'

Instantiate an instance of #{self.gem_file_name.titleize} to use it in your Ruby app.

    $ #{self.gem_file_name.titleize}::Magic.new.call

Save that instance in a variable and call any of your defined methods (#{self.method_names.join(', ')}) on it.

#{self.gem_name} was cut with love, by [Gem It](http://gemit.us/).

      EOT
      readme.close
    end

    def build_gemspec 
      # Create #{gem_file_name}.gemspec
      gemspec_name = File.join(@tmpdir, "#{self.gem_file_name}.gemspec")
      gemspec = File.new(gemspec_name, "w")
      gemspec.puts(<<-EOT)

# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require '#{self.gem_file_name}/version'

Gem::Specification.new do |spec|
  spec.name          = "#{self.gem_file_name}"
  spec.version       = #{self.gem_const}::VERSION
  spec.authors       = ["#{self.author}"]
  spec.email         = ["#{self.author_email}"]
  spec.summary       = "#{self.description}"
  spec.description   = %q{I thought this was optional}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = Dir['{bin/*,lib/**/*}'] +
                        %w(#{self.gem_file_name}.gemspec Rakefile README.md) 
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake", "~> 2.2"
  spec.add_development_dependency "nokogiri", "~> 2.2"

end

      EOT
      gemspec.close

    end

    def build_env
      # Create lib/gem.rb
      gem_file_name = File.join(self.lib_dir, "#{self.gem_file_name}.rb")
      gem = File.new(gem_file_name, "w")
      gem.puts(<<-EOT)

require "open-uri"
require "nokogiri"
Dir[File.dirname(__FILE__) + '/#{self.gem_file_name}/*.rb'].each do |file|
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

    def values_to_methods(values)
      string = "available methods: \n"
      values.each do |v| 
        v = v.keys[0]
        string += "\t`" + v.downcase.gsub(" ", "_").strip + "`\n" 
      end 
      string 
    end
  end
end