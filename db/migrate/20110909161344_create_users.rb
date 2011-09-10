class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :nick,  :limit => 16
      t.string  :name
      t.string  :email, :limit => 50

      t.timestamps
    end
    add_index :users, :nick,  :unique => true
    add_index :users, :email, :unique => true
  end
end
