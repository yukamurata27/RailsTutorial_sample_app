require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

# make colors change
require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  # Allows to use Application helper in teh test environment
  # Now you can use the 'full_title' helper in site_layout_test.rb
  include ApplicationHelper
end
