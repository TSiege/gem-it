class GemBuilder < ActiveRecord::Base

	def scaffold(name, creator)
		# Store gem directory names in variables
		gem_name = name
		gem_lib_dir = "#{gem_name}/lib"
		gem_lib_gem_dir = "#{gem_lib_dir}/#{gem_name}"

		# Create gem directory and nested lib directory
		Dir.mkdir(gem_name)
		Dir.mkdir(gem_lib_dir)
		Dir.mkdir(gem_lib_gem_dir)

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

		# Specify your gem's dependencies in gem.gemspec
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

		# Create gem.gemspec
		gemspec_name = File.join(gem_name, 'gem.gemspec')
		gemspec = File.new(gemspec_name, "w")
		gemspec.puts(<<-EOT)
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
		gemspec.close

		# Create lib/gem.rb
		gem_name = File.join(gem_lib_dir, 'gem.rb')
		gem = File.new(gem_name, "w")
		gem.puts(<<-EOT)
		require "gem/version"

		module #{name}Gem
		  # Your code goes here...
		end

		EOT
		gem.close

		# Create lib/gem/version.rb
		version_name = File.join(gem_lib_gem_dir, 'version.rb')
		version = File.new(version_name, "w")
		version.puts(<<-EOT)
		require "gem/version"

		module #{name}Gem
  		VERSION = "0.0.1"
		end

		EOT
		version.close
	end

end