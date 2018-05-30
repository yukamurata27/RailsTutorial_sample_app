class AddIndexToUsersEmail < ActiveRecord::Migration[5.1]
  def change
  	# use add_index method to add an index to 'email' column of 'users' table
  	add_index :users, :email, unique: true
  end
end