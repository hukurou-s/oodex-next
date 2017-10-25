source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'active_model_serializers'
# gem 'coffee-rails', '~> 4.2'
gem 'devise'
gem 'devise-i18n'
gem 'dotenv-rails', require: 'dotenv/rails-now'
gem 'font-awesome-rails'
gem 'kaminari'
gem 'mysql2', '>= 0.3.18', '< 0.5'
gem 'puma', '~> 3.7'
gem 'rack-dev-mark'
gem 'rails', '~> 5.1.4'
gem 'ransack'
gem 'sass-rails', '~> 5.0'
gem 'slim-rails'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'
gem 'webpacker'

gem 'simplecov', require: false, group: :test
gem 'simplecov-cobertura', require: false, group: :test

group :development, :test do
  gem 'annotate'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', require: false
  gem 'capybara-screenshot', require: false
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'fuubar'
  gem 'pry-byebug'
  gem 'pry-doc'
  gem 'pry-rails'
  gem 'rubocop'
  gem 'rubocop'
  gem 'selenium-webdriver'
  gem 'slim_lint'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rspec-rails', '~> 3.6'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
