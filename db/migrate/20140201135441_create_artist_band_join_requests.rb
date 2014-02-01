class CreateArtistBandJoinRequests < ActiveRecord::Migration
  def change
    create_table :artist_band_join_requests do |t|
      t.references :artist, index: true
      t.references :band, index: true
      t.boolean :artist_accepted, default: false
      t.boolean :band_accepted, default: false

      t.timestamps
    end
  end
end
