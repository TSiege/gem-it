class Gemifier

  include Buildable::InstanceMethods

  attr_accessor :gem_name, :gem_const, :author, :target_website,
                :author_email, :bin_dir, :lib_dir, :gemfiles_dir, :method_names,
                :client, :method_names_and_node_paths, :description, :repo, :gem_file_name

  def initialize(client, params)
    @client = client
    @repo = client.create_repo(params[:repo_name], {description: params[:description], :private => false})
    client.add_collaborator(@repo.full_name, 'GemIt')

    @author = client.user.login
    @author_email = params[:email]
    @description = params[:description]
    @target_website = params[:url]

    @gem_name = params[:gem_name]
    @gem_const = gem_name.split(/_| |-/).collect(&:titleize).join()
    @gem_file_name = gem_name.parameterize.gsub('-','_')
    
    @method_names_and_node_paths = create_hash(params[:method_name], params[:last_path])
    @method_names = params[:method_name]
    # @node_path_fallback = node_path.gsub(/tbody\[.\]/,"")
  end

  def scaffold
    
    Dir.mktmpdir do |tmpdir|
    
      @tmpdir = tmpdir

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

    end  

  end

  def destroy_directory 

  end

  private

  def make_dirs
    @bin_dir = "#{@tmpdir}/bin"
    @lib_dir = "#{@tmpdir}/lib"
    @gemfiles_dir = "#{lib_dir}/#{gem_file_name}"
    Dir.mkdir(lib_dir)
    Dir.mkdir(gemfiles_dir)
    Dir.mkdir(bin_dir, 0777)
  end

  def finalize_build
    app_path = Dir.pwd
    Dir.chdir(@tmpdir)
    %x(gem build #{gem_file_name}.gemspec)
    push_to_github
    Dir.chdir(app_path)
  end

  def push_to_github
    %x(git init)
    modify_git_config if Rails.env.prodution?
    %x(git add -A)
    %x(git commit -m "first commit")
    %x(git remote add origin #{repo.ssh_url})
    %x(git push -u origin master)
  end

  def modify_git_config
    Dir.chdir('.git')
    %x(rm config)
    git_config = (<<-EOT)

[core]
        repositoryformatversion = 0
        filemode = true
        bare = false
        logallrefupdates = true
[remote "origin"]
        url = git@github.com-gemit:#{@repo.full_name}.git
        fetch = +refs/heads/*:refs/remotes/origin/*

    EOT
    File.open('config', 'w+'){|f| f.write(git_config)}
    Dir.chdir('..')
  end

  def create_hash(labels, node_paths)
    labels.collect.with_index do |label, i|
      if !label.empty? && !node_paths[i].empty?
        {label => node_paths[i]}
      end  
    end 
  end

end