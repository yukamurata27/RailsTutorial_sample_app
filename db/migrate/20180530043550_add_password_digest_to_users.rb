class AddPasswordDigestToUsers < ActiveRecord::Migration[5.1]
  def change
  	# need to add password_digest column to use 'has_secure_password' in User model
    add_column :users, :password_digest, :string
  end
end
