class Jam < ActiveRecord::Base
  attr_accessible :artist_id, :jam_artist_name, :jam_creation_date, :jam_username, :jam_external_id, :jam_title, :jam_via, :jam_via_url
  belongs_to :artist
end
