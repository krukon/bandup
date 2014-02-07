class AddProfileAndCoverPicturesToArtist < ActiveRecord::Migration
  def change
  	change_table :artists do |t|
  		t.integer :profile_picture_id
  		t.integer :cover_picture_id
  	end
  end
end
