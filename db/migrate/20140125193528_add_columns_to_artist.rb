class AddColumnsToArtist < ActiveRecord::Migration
  def change
  	add_column :artists, :birthday, :datetime
  	add_column :artists, :location_city, :string
  	add_column :artists, :location_state, :string
  	add_column :artists, :link_facebook, :string
  	add_column :artists, :link_youtube, :string
  	add_column :artists, :link_website, :string
  end
end
