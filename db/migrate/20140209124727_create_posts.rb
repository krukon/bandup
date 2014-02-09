class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
    	t.string :content
    	t.string :link
    	t.references :artist
    	t.references :band
    	t.references :picture

      t.timestamps
    end
  end
end
