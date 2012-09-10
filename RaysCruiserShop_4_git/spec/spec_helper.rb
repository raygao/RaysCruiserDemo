# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'factory_girl'
require 'database_cleaner'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  config.mock_with :rspec

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  # config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  # config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # read    http://jimdrannbauer.com/2011/01/29/rails-3-rspec-cucumber-jquery-devise-mongoid-and-compass/
  config.before(:suite) do
     DatabaseCleaner.strategy = :truncation
     DatabaseCleaner.orm = "mongoid"
   end

   config.before(:each) do
     DatabaseCleaner.clean
     # Also need to clean up Redis, see reflectadmin project
   end

  # Adding mongoid support to Rspec file.
  # see:  http://cysemic.com/2010/03/getting-cucumber-rspec-and-mongoid-to-play-nice/
  #config.before(:each) do
  #  Mongoid.master.collections.each(&:drop)
    # Also need to clean up Redis, see reflectadmin project
  #end
end
