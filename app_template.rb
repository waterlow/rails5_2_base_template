require 'bundler'

gem_group :default do
  gem 'hamlit'
end

gem_group :development do
  gem 'hamlit-rails'
  gem 'erb2haml'
end

Bundler.with_clean_env do
  run 'bundle install'
  run 'bundle exec rake haml:replace_erbs'
end

gsub_file 'Gemfile', /  gem 'erb2haml'\n/, ''
