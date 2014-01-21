class CreateArtistInstrumentRelations < ActiveRecord::Migration
  def change
    create_table :artist_instrument_relations do |t|
    	t.integer :artist_id
    	t.integer :instrument_id

      t.timestamps
    end
  end
end
