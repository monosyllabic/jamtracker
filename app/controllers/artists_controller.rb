require 'thisismyjam'

class ArtistsController < ApplicationController
  # GET /artists
  # GET /artists.json
  def index
    @artists = Artist.order("name").all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @artists }
    end
  end

  # GET /artists/1
  # GET /artists/1.json
  def show
    @artist = Artist.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @artist }
    end
  end

  # GET /artists/new
  # GET /artists/new.json
  def new
    @artist = Artist.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @artist }
    end
  end

  # GET /artists/1/edit
  def edit
    @artist = Artist.find(params[:id])
  end

  # POST /artists
  # POST /artists.json
  def create
    @artist = Artist.new(params[:artist])

    respond_to do |format|
      if @artist.save
        format.html { redirect_to @artist, notice: 'Artist was successfully created.' }
        format.json { render json: @artist, status: :created, location: @artist }
      else
        format.html { render action: "new" }
        format.json { render json: @artist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /artists/1
  # PUT /artists/1.json
  def update
    @artist = Artist.find(params[:id])

    respond_to do |format|
      if @artist.update_attributes(params[:artist])
        format.html { redirect_to @artist, notice: 'Artist was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @artist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /artists/1
  # DELETE /artists/1.json
  def destroy
    @artist = Artist.find(params[:id])
    @artist.destroy

    respond_to do |format|
      format.html { redirect_to artists_url }
      format.json { head :no_content }
    end
  end

  # GET /artists/1/sync
  # GET /artists/1/sync.json
  def sync
    @artist = Artist.find(params[:id])
    @newJams = sync_inner(@artist)
    respond_to do |format|
      format.html # sync.html.erb
      format.json { render json: { @artist => @newJams } }
    end   
  end

  # GET /artists/sync_all
  # GET /artists/sync_all.json
  def sync_all
    @artists = Artist.all
    @newJamsByArtist = {}
    @artists.each { |artist| @newJamsByArtist[artist] = sync_inner(artist) }
    respond_to do |format|
      format.html # sync_all.html.erb
      format.json { render json: @newJamsByArtist }
    end   
  end

  def sync_inner(artist)
    newJams = Array.new
    searchResults = Thisismyjam.searchByArtist(artist.name)["jams"].find_all{ |jam| jam["artist"].casecmp(artist.name) == 0 }
    searchResults.each do |result|
      unless Jam.find_by_jam_external_id(result["id"])
        newJam = artist.jams.new({ jam_artist_name: result["artist"], jam_creation_date: Time.parse(result["creationDate"]), jam_username: result["from"], jam_external_id: result["id"], jam_title: result["title"], jam_via: result["via"], jam_via_url: result["viaUrl"] })
        newJam.save
        newJams.push(newJam)
      end
    end
    return newJams
  end
end
