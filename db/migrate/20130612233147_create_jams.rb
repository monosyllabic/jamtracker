class CreateJams < ActiveRecord::Migration
  def change
    create_table :jams do |t|
      t.integer :artist_id
      t.string :jam_artist_name
      t.timestamp :jam_creation_date
      t.string :jam_external_id
      t.string :jam_title
      t.string :jam_username
      t.string :jam_via
      t.string :jam_via_url
      t.boolean :removed, :default => false

      t.timestamps
    end
    add_index :jams, [:artist_id, :created_at]
  end
end
