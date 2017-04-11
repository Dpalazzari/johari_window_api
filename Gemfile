source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


gem 'rails', '~> 5.0.1'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'
gem 'active_model_serializers', '~> 0.10.0'
gem 'faraday'
gem 'rack-cors'
gem 'faker'
gem 'redcarpet'
gem 'rack-cors', :require => 'rack/cors'
gem 'figaro'


group :development, :test do
  gem 'pry-state', platform: :mri
  gem 'rspec-rails', '~> 3.5'
  gem 'capybara'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'vcr'
  gem 'webmock'
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
