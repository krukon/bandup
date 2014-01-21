class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
    	t.string :email
    	t.string :first_name
    	t.string :last_name
    	t.string :password_digest
    	t.string :stage_name
    	t.string :about
    	t.boolean :admin, default: false

      t.timestamps
    end

    add_index :artists, :email, unique: true

  end
end
