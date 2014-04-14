namespace :clear do
  task :pages => [:environment] do 
    FileUtils.rm_rf(Dir.glob('public/tmp/*'))
  end 
end
