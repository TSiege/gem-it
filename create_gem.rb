# Store gem directory names in variables
test_gem_dir = 'testing_gem'
test_lib_dir = "#{test_gem_dir}/lib"
test_lib_test_dir = "#{test_lib_dir}/#{test_gem_dir}"

# Create gem directory and nested lib directory
Dir.mkdir(test_gem_dir)
Dir.mkdir(test_lib_dir)
Dir.mkdir(test_lib_test_dir)

# Create .gitignore
test_gitignore_name = File.join(test_gem_dir, '.gitignore')
test_gitignore = File.new(test_gitignore_name, "w")
test_gitignore.puts(<<-EOT)
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
test/tmp
test/version_tmp
tmp

EOT
test_gitignore.close

# Create Gemfile
test_gemfile_name = File.join(test_gem_dir, 'Gemfile')
test_gemfile = File.new(test_gemfile_name, "w")
test_gemfile.puts(<<-EOT)
source 'https://rubygems.org'

# Specify your gem's dependencies in test_gem.gemspec
gemspec

EOT
test_gemfile.close

# Create License.txt
test_license_name = File.join(test_gem_dir, 'License.txt')
test_license = File.new(test_license_name, "w")
test_license.puts(<<-EOT)
source 'https://rubygems.org'

Copyright (c) 2014 <pat-whitrock>

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
test_license.close

# Create Rakefile
test_rakefile_name = File.join(test_gem_dir, 'Rakefile')
test_rakefile = File.new(test_rakefile_name, "w")
test_rakefile.puts(<<-EOT)
require "bundler/gem_tasks"

EOT
test_rakefile.close

# Create README.md
test_readme_name = File.join(test_gem_dir, 'README.md')
test_readme = File.new(test_readme_name, "w")
test_readme.puts(<<-EOT)
# TestGem

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'test_gem'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install test_gem

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it ( http://github.com/<my-github-username>/test_gem/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

EOT
test_readme.close

# Create test_gem.gemspec
test_gemspec_name = File.join(test_gem_dir, 'test_gem.gemspec')
test_gemspec = File.new(test_gemspec_name, "w")
test_gemspec.puts(<<-EOT)
# TestGem

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'test_gem'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install test_gem

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it ( http://github.com/<my-github-username>/test_gem/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

EOT
test_gemspec.close

# Create lib/test_gem.rb
test_test_gem_name = File.join(test_lib_dir, 'test_gem.rb')
test_test_gem = File.new(test_test_gem_name, "w")
test_test_gem.puts(<<-EOT)
require "test_gem/version"

module TestGem
  # Your code goes here...
end

EOT
test_test_gem.close

# Create lib/test_gem/version.rb
test_version_name = File.join(test_lib_test_dir, 'version.rb')
test_version = File.new(test_version_name, "w")
test_version.puts(<<-EOT)
require "test_gem/version"

module TestGem
	VERSION = "0.0.1"
end

EOT
test_version.close