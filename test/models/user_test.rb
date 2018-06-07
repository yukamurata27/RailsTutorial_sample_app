# $ rails test:models for this specific test
# or do $ rails test

# u1.errors.full_messages shows you error messages when it's not valid
# Similarly u1.errors.messages shows you error messages in a hash format
#      u1.errors.messages[:email] shows you an error message for 'email'
# if it's not valid, you fail to save the User object

# Don't forget to tie up to User model file (set validations) l.29, 24, 39

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    # @user = User.new(name: "Example User", email: "user@example.com",
    # after adding has_secure_password
    @user = User.new(name: "Example User", email: "user@example.com",
    			password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
  	@user.name = "  "
  	assert_not @user.valid?
  end

  test "email should be present" do
  	@user.email = ""
  	assert_not @user.valid?
  end

  test "name should not be too long" do
  	@user.name = "a" * 51
  	assert_not @user.valid?
  end

  test "email should not be too long" do
  	@user.email = "a" *244 + "@example.com"
  	assert_not @user.valid?
  end

  # test for VALID emails
  test "email validation should accept valid addresses" do
  	valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      # second argument below is an error message to be shown
      # #{} is used inside of quotation ("") as the variable (here is valid_address)
      # inspect returns a string expressing the requested object (it literally shows as an object)
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  # test for INVALID emails
  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
  	# make a duplicate and save it to DB
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email addresses should be saved as lower-case" do
  	mixed_case_email = "Foo@ExAMPle.CoM"
  	@user.email = mixed_case_email
  	@user.save
  	# 'reload' method updates DB accordingly
  	assert_equal mixed_case_email.downcase, @user.reload.email
  end

  # add validation to User mdoel for the length
  test "password should have a minimum length" do
  	@user.password = @user.password_confirmation = "a" * 5
  	assert_not @user.valid?
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end

  # dependent: :destroyのテスト

  test "associated microposts should be destroyed" do
    @user.save
    @user.microposts.create!(content: "Lorem ipsum")
    assert_difference 'Micropost.count', -1 do
      @user.destroy
    end
  end
end
