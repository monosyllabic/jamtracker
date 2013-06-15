class JamsController < ApplicationController
 
  # POST /jams
  # POST /jams.json
  def create
    @jam = Jam.new(params[:jam])

    respond_to do |format|
      if @jam.save
        format.html { redirect_to @jam, notice: 'Jam was successfully created.' }
        format.json { render json: @jam, status: :created, location: @jam }
      else
        format.html { render action: "new" }
        format.json { render json: @jam.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jams/1
  # DELETE /jams/1.json
  def destroy
    @jam = Jam.find(params[:id])
    @jam.destroy

    respond_to do |format|
      format.html { redirect_to jams_url }
      format.json { head :no_content }
    end
  end

  # GET /jams/1/remove
  # GET /jams/1/remove.json
  def remove
    @jam = Jam.find(params[:id])

    respond_to do |format|
      if @jam.update_attributes(:removed => "true")
        format.html { redirect_to :root, notice: 'Jam was successfully removed.' }
        format.json { head :no_content }
      else
        format.html { redirect_to :root }
        format.json { render json: @jam.errors, status: :unprocessable_entity }
      end
    end
  end
end
