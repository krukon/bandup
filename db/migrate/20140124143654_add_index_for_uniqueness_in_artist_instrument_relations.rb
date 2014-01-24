class AddIndexForUniquenessInArtistInstrumentRelations < ActiveRecord::Migration
  def change
  	add_index :artist_instrument_relations, [:artist_id, :instrument_id], unique: true
  end
end
