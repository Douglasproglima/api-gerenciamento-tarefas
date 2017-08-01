class AddAuthTokenToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :auth_tokens, :string
    add_index :users, :auth_tokens, unique: true
  end
end
