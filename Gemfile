source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


gem 'rails', '~> 5.1.5'
# db
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.7'
# front
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'webpacker', '~> 3.2.1'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
# auth
gem 'devise'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-twitter'
gem 'omniauth-github'
gem 'banken'
# view
gem 'cloudinary'
gem 'carrierwave'
gem 'rack-dev-mark'
# functional
gem 'kaminari'
# non-functional
gem 'dotenv-rails'
gem 'faker'
# template engine
gem 'slim-rails'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
  gem 'byebug'
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'database_cleaner'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'rubocop', require: false
  gem 'foreman'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
  gem 'rails_best_practices'
  gem 'spring-commands-rspec'
end

group :production, :staging do
  gem 'rails_12factor'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
