class CreateGalCategories < ActiveRecord::Migration
  def change
    create_table :gal_categories do |t|
      t.string :name, :limit => 50, :null => false
      t.string :description
      t.string :permalink, :limit => 50, :null => false
      t.integer :status, :default => 0

      t.timestamps
    end
    add_index :gal_categories, :permalink,  :unique => true
  end
end
