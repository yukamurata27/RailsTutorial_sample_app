require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

	# excuted right before tests' excution
	def setup
		# Reduce a duplicate
		@base_title = "Ruby on Rails Tutorial Sample App"	# this can be used with #{@base_title}		
	end
  
   	# Tests following below
   	test "should get root" do
    	get root_url
    	assert_response :success
  	end

  	test "should get home" do
    	# get static_pages_home_url
    	get root_path
      assert_response :success
    	# assert_select checks if there exists such a tag (e.g. title tag that has Home | xxx)
  		assert_select "title", "#{@base_title}"
  	end

  	test "should get help" do
   		# 1) get static_pages_help_url
    	# 2) get help_path
      # 3)
      get help_path
      assert_response :success
    	assert_select "title", "Help | #{@base_title}"
  	end

  	test "should get about" do
  		# get static_pages_about_url
  		get about_path
      assert_response :success
  		assert_select "title", "About | #{@base_title}"
  	end

  	test "should get contact" do
  		# get static_pages_contact_url
  		get contact_path
      assert_response :success
  		assert_select "title", "Contact | #{@base_title}"
  	end

  	test "should get partial" do
  		# get static_pages_home_url
    	get root_path
      assert_response :success
    	assert_select "title", "#{@base_title}"
  	end

end
