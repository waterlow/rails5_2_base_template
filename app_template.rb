require 'bundler'

gem 'hamlit'
gem 'babel-transpiler'
gem 'sprockets', '4.0.0.beta7'
gem_group :development do
  gem 'hamlit-rails'
  gem 'erb2haml'
end

Bundler.with_clean_env do
  run 'bundle install'
  run 'bundle exec rake haml:replace_erbs'
end

gsub_file 'Gemfile', /  gem 'erb2haml'\n/, ''
