class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
    	t.string :title
    	t.string :description
    	t.references :artist, index: true

      t.timestamps
    end
  end
end
