module ArtistsHelper

def getNewJams (artist)
  # search results may contain jams by other artists, so we need to filter those out
  # @searchResults = Thisismyjam.searchbyartist(artist)["jams"].find_all{ |jam| jam["artist"].casecmp('artist') == 0 })
  # @jams = Jam.find_by_artist(artist)

#  compare filtered result jams to jams that exist in db; add only those jams to db that are not in db
end

end
