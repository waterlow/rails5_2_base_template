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

run 'rm -rf app/assets/stylesheets/application.css'
get(
  'https://raw.github.com/morizyun/rails5_application_template/master/app/assets/stylesheets/application.scss',
  'app/assets/stylesheets/application.scss'
)

insert_into_file 'app/assets/javascripts/application.js', %(
  //= require jquery3
  //= require popper
  //= require bootstrap-sprockets
), before: '//= require_tree .'

gsub_file 'Gemfile', /\/\/= require_tree .\n/, ''
