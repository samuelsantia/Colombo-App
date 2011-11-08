class CreateGalAlbums < ActiveRecord::Migration
  def change
    create_table :gal_albums do |t|
      t.integer :gal_category_id
      t.string :name, :limit => 50, :null => false
      t.string :description
      t.string :permalink, :limit => 50, :null => false
      t.integer :status, :default => 0

      t.timestamps
    end
    add_index :gal_albums, :name,      :unique => true
    add_index :gal_albums, :permalink, :unique => true
  end
end
