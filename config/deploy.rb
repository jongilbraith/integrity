set :application, "integrity"
set :domain, "ci.professionalnerd.com"
set :user, "jon"
set :app_server, :passenger
set :scm, :git

# Required to make sure Github can use the public key on my local machine
ssh_options[:forward_agent] = true

set :repository, "git@github.com:professionalnerd/integrity.git"
set :deploy_to, "/home/jon/web/ci.professionalnerd.com"
set :branch, "professionalnerd"

role :app, 'hoth.econsultancy.com'
role :web, 'hoth.econsultancy.com'

# Inside the finalize_update task, there is a bit of logic
# that barfs due to the lack of these railsesque directories.
set :normalize_asset_timestamps, false

before "deploy:restart", "deploy:copy_config"
before "deploy:restart", "deploy:bundle"

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
    run "cd #{deploy_to}/current && bundle install"
    run "cd #{deploy_to}/current && bundle lock"
  end

  task :copy_config do
    run "cd #{deploy_to} && cp -rp shared/config/init.rb current"
  end
end
