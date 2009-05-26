class DownloadCodesController < ApplicationController
  before_filter :login_required
  
  # GET /download_codes
  # GET /download_codes.xml
  def index
    @download_codes = DownloadCode.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @download_codes }
    end
  end

  # GET /download_codes/1
  # GET /download_codes/1.xml
  def show
    @download_code = DownloadCode.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @download_code }
    end
  end

  # GET /download_codes/1/edit
  def edit
    @download_code = DownloadCode.find(params[:id])
  end

  # PUT /download_codes/1
  # PUT /download_codes/1.xml
  def update
    @download_code = DownloadCode.find(params[:id])

    respond_to do |format|
      if @download_code.update_attributes(params[:download_code])
        flash[:notice] = 'Download Code was successfully updated.'
        format.html { redirect_to(@download_code) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @download_code.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /download_codes/1
  # DELETE /download_codes/1.xml
  def destroy
    @download_code = DownloadCode.find(params[:id])
    @download_code.destroy

    respond_to do |format|
      format.html { redirect_to(download_codes_url) }
      format.xml  { head :ok }
    end
  end
end
