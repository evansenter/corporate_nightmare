class BatchesController < ApplicationController
  before_filter :login_required
  
  # GET /batches
  # GET /batches.xml
  def index
    @batches = Batch.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @batches }
    end
  end

  # GET /batches/1
  # GET /batches/1.xml
  def show
    @batch = Batch.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @batch }
    end
  end

  # GET /batches/new
  # GET /batches/new.xml
  def new
    @batch = Batch.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @batch }
    end
  end

  # POST /batches
  # POST /batches.xml
  def create
    @batch = Batch.new(params[:batch])
    
    ActiveRecord::Base.transaction do
      @batch.save!
      DownloadCode.create_in_bulk!(@batch)
    end

    respond_to do |format|
      flash[:notice] = 'Batch was successfully created.'
      format.html { redirect_to(@batch) }
      format.xml  { render :xml => @batch, :status => :created, :location => @batch }
    end
  rescue ActiveRecord::RecordInvalid
    @batch.errors.add_to_base "There was an error creating this batch of downloads"
    
    respond_to do |format|
      format.html { render :action => "new" }
      format.xml  { render :xml => @batch.errors, :status => :unprocessable_entity }
    end
  end

  # DELETE /batches/1
  # DELETE /batches/1.xml
  def destroy
    @batch = Batch.find(params[:id])
    @batch.destroy

    respond_to do |format|
      format.html { redirect_to(batches_url) }
      format.xml  { head :ok }
    end
  end
end
