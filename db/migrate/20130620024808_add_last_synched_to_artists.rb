class AddLastSynchedToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :last_synched, :timestamp
  end
end
