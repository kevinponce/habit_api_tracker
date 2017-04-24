# frozen_string_literal: true

require 'rubygems'
require 'spork'
require 'webmock/rspec'
require 'simplecov'
require 'database_cleaner'
require 'factory_girl_rails'

SimpleCov.start

Spork.prefork do
  RSpec.configure do |config|
    config.mock_with :rspec

    config.order = 'random'

    config.before(:suite) do
      DatabaseCleaner.strategy = :transaction
    end

    config.before(:each) do
      DatabaseCleaner.start
    end

    config.after(:each) do
      DatabaseCleaner.clean
    end
  end
end

Spork.each_run do
  # This code will be run each time you run your specs.
end

Dir['./spec/support/custom_matchers/**/*.rb'].each { |f| require f }

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
