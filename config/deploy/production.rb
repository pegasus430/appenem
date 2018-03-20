server '52.207.235.141', user: 'ubuntu', roles: %w{app db web}

set :stage, :production
set :rails_env, "production"
set :puma_env,  "production"
set :puma_config_file, "#{shared_path}/config/puma.rb"
set :puma_conf, "#{shared_path}/config/puma.rb"