class AddRememberTokenToArtist < ActiveRecord::Migration
  def change
  	add_column :artists, :remember_token, :string
  	add_index :artists, :remember_token
  end
end
