ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'vcr'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }


ActiveRecord::Migration.maintain_test_schema!

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec

    with.library :rails
  end
end

VCR.configure do |config|
  config.cassette_library_dir = Rails.root.join("spec", "fixtures", "vcr_cassettes")
  config.hook_into :webmock
  config.filter_sensitive_data('<CENSUS_CLIENT_ID>') { ENV["CENSUS_CLIENT_ID"] }
  config.filter_sensitive_data('<CENSUS_SECRET_ID>') { ENV["CENSUS_SECRET_ID"] }
  config.filter_sensitive_data('<CENSUS_TOKEN>') { ENV["CENSUS_TOKEN"] }
end

RSpec.configure do |config|
 
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

   # Config for VCR
  config.around(:each, :vcr) do |example|
    name = example.metadata[:full_description].split(/\s+/, 2).join("/").underscore.gsub(/[^\w\/]+/, "_")
    VCR.use_cassette(name) { example.call }
  end

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!
end
