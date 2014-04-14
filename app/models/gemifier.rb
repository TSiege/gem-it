require 'tmpdir'

class Gemifier

  include Buildable::InstanceMethods

  attr_accessor :gem_name, :gem_const, :author, :url, :website,
                :author_email, :bin_dir, :lib_dir, :gemfiles_dir, 
                :client, :values, :description, :repo, :gem_file_name

  def initialize(name, author, website, author_email, client, values, description, repo)
    @gem_name = name
    @author = author
    @website = website
    @values = values
    # @node_path_fallback = node_path.gsub(/tbody\[.\]/,"")
    @author_email = author_email
    @gem_const = gem_name.split(/_| |-/).collect(&:titleize).join()
    @gem_file_name = name.parameterize.gsub('-','_')
    @client = client
    @description = description
    @repo = repo
  end

  def scaffold
    
    # Dir.mktmpdir(gem_file_name, "/var/tmp") do |dir|

      tmp_dir_name = Dir.mktmpdir
      Dir.chdir(tmp_dir_name)
      make_dirs
          
      build_info_rb  
      build_model_rb
      build_runner
      build_gitignore 
      build_gemfile
      build_license 
      build_rakefile
      build_readme
      build_gemspec 
      build_env
      build_version 

      finalize_build

    # repo.create

    # end  

  end

  private

  def make_dirs
    @bin_dir = "#{gem_file_name}/bin"
    @lib_dir = "#{gem_file_name}/lib"
    @gemfiles_dir = "#{lib_dir}/#{gem_file_name}"
    Dir.mkdir(gem_file_name)
    Dir.mkdir(lib_dir)
    Dir.mkdir(gemfiles_dir)
    Dir.mkdir(bin_dir, 0777)
  end

  def finalize_build
    Dir.chdir(gem_file_name)
    %x(gem build #{gem_file_name}.gemspec)
    push_to_github
    Dir.chdir('..')
  end

  def push_to_github
    %x(git init)
    %x(git add -A)
    %x(git commit -m "first commit")
    %x(git remote add origin #{repo.ssh_url})
    %x(git push -u origin master)
  end

end