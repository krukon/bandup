class AddUsernameToArtist < ActiveRecord::Migration
  def change
  	add_column :artists, :username, :string
  	add_index :artists, :username, unique: true
  end
end
