set :application, "integrity"
set :domain, "ci.econsultancy.com"
set :user, "econsultancy"
set :app_server, :passenger
set :scm, :git

# Required to make sure Github can use the public key on my local machine
ssh_options[:forward_agent] = true

set :repository, "git@github.com:professionalnerd/integrity.git"
set :deploy_to, "/home/econsultancy/web/ci.econsultancy.com"
set :branch, "econsultancy"

role :app, 'hoth.econsultancy.com'
role :web, 'hoth.econsultancy.com'

# Inside the finalize_update task, there is a bit of logic
# that barfs due to the lack of these railsesque directories.
set :normalize_asset_timestamps, false

after  "deploy:update_code", "deploy:symlink_build_dir"
after  "deploy:update_code", "deploy:copy_config"
after  "deploy:update_code", "deploy:bundle"
after  "deploy:restart", "dj:restart"

namespace :deploy do
  task :start, :roles => [:web, :app] do
    puts "This is mod_rails - can't do that I'm afraid!"
  end

  task :stop, :roles => [:web, :app] do
    puts "This is mod_rails - can't do that I'm afraid!"
  end

  task :restart, :roles => [:web, :app] do
    run "cd #{deploy_to}/current && touch tmp/restart.txt"
  end

  task :migrate do
    run "cd #{deploy_to}/current && rake db"
  end

  task :bundle do
    run "cd #{release_path} && bundle install"
    run "cd #{release_path} && bundle lock"
  end

  task :copy_config do
    run "cp -rp #{shared_path}/config/init.rb #{release_path}"
  end

  task :symlink_build_dir do
    run "ln -s #{shared_path}/builds #{release_path}/builds"
  end
end

namespace :dj do
  task :restart do
    run "sudo /usr/local/bin/monit restart delayed_job_integrity_econsultancy"
  end
end
