# type
# $ rails test:integration

require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  # Test HTML structure in this application and see if all links work
  # This literally checks HTML code generated
  # 1) Send a GET request to root URL (homepage)
  # 2) Check if the right page template is drawn
  # 3) Check if links (Home, Help, About, Contact) work correctly

  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    # assert_select tests html tag
    # can check if there're 2 such HTML code with 'count: 2'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    # ? replaces with about_paht. Following checks if <a href="/about">...</a> exits
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path

    # use the 'full_title helper in the test environment'
    # need to add 'include ApplicationHelper' to test_helper.rb
    get contact_path
    assert_select "title", full_title("Contact")

    # test for signup_path
    get signup_path
    assert_select "title", full_title("Sign up")
  end
end

# Note (examples of use of options for 'assert_select')
#
#                  CODE                                       MATCHED HTML
# assert_select "div"	                               <div>foobar</div>
# assert_select "div", "foobar"	                       <div>foobar</div>
# assert_select "div.nav"	                           <div class="nav">foobar</div>
# assert_select "div#profile"	                       <div id="profile">foobar</div>
# assert_select "div[name=yo]"	                       <div name="yo">hey</div>
# assert_select "a[href=?]", ’/’, count: 1	           <a href="/">foo</a>
# assert_select "a[href=?]", ’/’, text: "foo"          <a href="/">foo</a>