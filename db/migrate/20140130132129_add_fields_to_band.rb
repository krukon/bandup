class AddFieldsToBand < ActiveRecord::Migration
  def change
  	add_column :bands, :page, :string
  	add_column :bands, :link_website, :string
  	add_column :bands, :link_facebook, :string
  	add_column :bands, :link_youtube, :string
  	add_column :bands, :established, :datetime
  end
end
