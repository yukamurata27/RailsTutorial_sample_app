# Test for helpers
# This file is especially for application helper

# need the following to use application helper (there is such code)
require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase

  # test for full_title (from applicarion helper)
  test "full title helper" do
  	# assert_equal USE_of_METHOD, EXPECTED_VALUE
    assert_equal full_title,         "Ruby on Rails Tutorial Sample App"
    assert_equal full_title("Help"), "Help | Ruby on Rails Tutorial Sample App"
  end
end