require 'bundler'

gem 'hamlit'
gem 'babel-transpiler'
gem 'sprockets', '4.0.0.beta7'
gem 'bootstrap'
gem 'jquery-rails'
gem_group :development do
  gem 'hamlit-rails'
  gem 'erb2haml'
end

Bundler.with_clean_env do
  run 'bundle install'
  run 'bundle exec rake haml:replace_erbs'
end

gsub_file 'Gemfile', /  gem 'erb2haml'\n/, ''
gsub_file 'Gemfile', /gem 'coffee-rails'.+\n/, ''

run 'rm -rf app/assets/stylesheets/application.css'
get(
  'https://raw.githubusercontent.com/waterlow/rails5_2_base_template/bootstrap4/app/assets/stylesheets/application.scss',
  'app/assets/stylesheets/application.scss'
)
get(
  'https://raw.githubusercontent.com/waterlow/rails5_2_base_template/bootstrap4/app/assets/stylesheets/common.scss',
  'app/assets/stylesheets/common.scss'
)

insert_into_file 'app/assets/javascripts/application.js',
%(//= require jquery3
//= require popper
//= require bootstrap-sprockets
), before: '//= require_tree .'

gsub_file 'Gemfile', /\/\/= require_tree .\n/, ''

run 'rm -rf app/views/layouts/application.html.haml'
get(
  'https://raw.githubusercontent.com/waterlow/rails5_2_base_template/bootstrap4/app/views/layouts/application.html.haml',
  'app/views/layouts/application.html.haml'
)

application  do
  %q{
    # Set timezone
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local
    # Set locale
    I18n.enforce_available_locales = true
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :ja
    # Set generator
    config.generators do |g|
      g.controller_specs false
      g.routing_specs false
      g.helper_specs false
      g.request_specs false
      g.assets false
      g.helper false
    end
  }
end

generate(:controller, 'home index')
route "root 'home#index'"

run 'rm -rf app/views/home/index.html.haml'
get(
  'https://raw.githubusercontent.com/waterlow/rails5_2_base_template/bootstrap4/app/views/home/index.html.haml',
  'app/views/home/index.html.haml'
)
