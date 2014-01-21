class CreateArtistBandRelations < ActiveRecord::Migration
  def change
    create_table :artist_band_relations do |t|
    	t.integer :artist_id
    	t.integer :band_id
    	t.boolean :owner

      t.timestamps
    end

    add_index :artist_band_relations, [:artist_id, :band_id], unique: true
  end
end
