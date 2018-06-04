require 'rails_helper'

RSpec.describe User, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"

  subject { User.new(name: "Example User", email: "user@example.com",
    			password: "foobar", password_confirmation: "foobar") }

  # methoods
  describe '#new' do
    #it { expect(subject).to be_a(User) }
    it { expect(subject.valid?).to be true }
  
  	# context = when
  	context "Name" do
  		it "should have name" do
  			subject.name = "  "
  			expect(subject.valid?).to be false
  		end

  		it "should not have too long name" do
  			subject.name = "a" * 51
  			expect(subject.valid?).to be false
  		end
  	end

  	context "Email" do
  		it "should have email" do
  			subject.email = ""
  			expect(subject.valid?).to be false
  		end

  		it "should not have too long email" do
  			subject.email = "a" *244 + "@example.com"
  			expect(subject.valid?).to be false
  		end

  		it "should accept valid address" do
  			valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                        		 first.last@foo.jp alice+bob@baz.cn]

    		valid_addresses.each do |valid_address|
    			subject.email = valid_address
    			expect(subject.valid? "#{valid_address.inspect} should be valid").to be true
    		end
  		end

  		it "should not accept invalid address" do
  			invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                    			   foo@bar_baz.com foo@bar+baz.com foo@bar..com]

            invalid_addresses.each do |invalid_address|
            	subject.email = invalid_address
            	expect(subject.valid? "#{invalid_address.inspect} should be invalid").to be false
            end
  		end

  		it "should be unique" do
  			#@user = subject
  			#duplicate_user = @user.dup
    		#duplicate_user.email = @user.email.upcase
   			#@user.save
   			#expect(duplicate_user.valid?).to be false

   			duplicate_user = subject.dup
    		duplicate_user.email = subject.email.upcase
   			subject.save
   			expect(duplicate_user.valid?).to be false
  		end



	end
  end

end
