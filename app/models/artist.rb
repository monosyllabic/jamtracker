class Artist < ActiveRecord::Base
  attr_accessible :name
  validates :name, :presence => true, :uniqueness => {:case_sensitive => false}
  has_many :jams, :dependent => :delete_all

  def self.sync_all
    newJamsByArtist = {}
    Artist.all.each { |artist| newJamsByArtist[artist] = artist.sync }
    return newJamsByArtist
  end

  def sync
    newJams = Array.new
    searchResults = Thisismyjam.searchByArtist(name)["jams"].find_all{ |jam| jam["artist"].casecmp(name) == 0 }
    searchResults.each do |result|
      unless Jam.find_by_jam_external_id(result["id"])
        newJam = jams.new({ jam_artist_name: result["artist"], jam_creation_date: Time.parse(result["creationDate"]), jam_username: result["from"], jam_external_id: result["id"], jam_title: result["title"], jam_via: result["via"], jam_via_url: result["viaUrl"] })
        newJam.save
        newJams.push(newJam)
      end
    end
    return newJams
  end
end
