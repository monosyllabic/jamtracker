require 'httparty'

class Thisismyjam
	include HTTParty
	base_uri 'api.thisismyjam.com'

	def self.searchByArtist( artist )
		search('artist', artist.gsub(/\s+/,'+'))
	end

	def self.search( type, query )
		get( '/1/search/jam.json', :query => { :by => type, :q => query } )
	end
end