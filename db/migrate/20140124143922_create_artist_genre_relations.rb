class CreateArtistGenreRelations < ActiveRecord::Migration
  def change
    create_table :artist_genre_relations do |t|
    	t.integer :artist_id
    	t.integer :genre_id

      t.timestamps
    end

    add_index :artist_genre_relations, [:artist_id, :genre_id], unique: true
  end
end
