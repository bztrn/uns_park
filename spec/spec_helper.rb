require 'factory_girl'
require "paperclip/matchers"
require 'sunspot/rails/spec_helper'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  
  config.include FactoryGirl::Syntax::Methods
  config.include Paperclip::Shoulda::Matchers

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  
  config.before(:each) do
    ::Sunspot.session = ::Sunspot::Rails::StubSessionProxy.new(::Sunspot.session)
  end

  config.after(:each) do
    ::Sunspot.session = ::Sunspot.session.original_session
  end
end

FactoryGirl.definition_file_paths = [File.expand_path('../factories', __FILE__)]
FactoryGirl.find_definitions

