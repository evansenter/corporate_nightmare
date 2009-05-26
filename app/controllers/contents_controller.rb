class ContentsController < ApplicationController
  before_filter :login_required, :except => [:index, :show, :download, :authorize_download]
  
  # GET /contents
  # GET /contents.xml
  def index
    @contents = Content.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @contents }
    end
  end

  # GET /contents/1
  # GET /contents/1.xml
  def show
    @content = Content.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @content }
    end
  end

  # GET /contents/new
  # GET /contents/new.xml
  def new
    @content = Content.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @content }
    end
  end

  # GET /contents/1/edit
  def edit
    @content = Content.find(params[:id])
  end

  # POST /contents
  # POST /contents.xml
  def create
    @content = Content.new(params[:content])

    respond_to do |format|
      if @content.save
        flash[:notice] = 'Content was successfully created.'
        format.html { redirect_to(@content) }
        format.xml  { render :xml => @content, :status => :created, :location => @content }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @content.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /contents/1
  # PUT /contents/1.xml
  def update
    @content = Content.find(params[:id])

    respond_to do |format|
      if @content.update_attributes(params[:content])
        flash[:notice] = 'Content was successfully updated.'
        format.html { redirect_to(@content) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @content.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /contents/1
  # DELETE /contents/1.xml
  def destroy
    @content = Content.find(params[:id])
    @content.destroy

    respond_to do |format|
      format.html { redirect_to(contents_url) }
      format.xml  { head :ok }
    end
  end
  
  def download
    @content = Content.find(params[:id])
    
    respond_to do |format|
      format.html # download.html.erb
      format.xml  { render :xml => @contents }
    end
  end
  
  def authorize_download
    @content = Content.find(params[:content_id])
      
    if used_code = DownloadCode.use_download_code!(params[:key])      
      send_file @content.file.url(:original, false)
      
      if used_code.contents.include?(@content)
        sql = <<-SQL
          UPDATE contents_download_codes
          SET    count = count + 1
          WHERE  content_id = #{@content.id} AND download_code_id = #{used_code.id}
        SQL
        
        ActiveRecord::Base.connection.execute(sql)
      else
        used_code.contents << @content 
      end
    else
      flash.now[:notice] = "There was an error using your download code. Please try again."
      render :action => "download", :id => @content.id
    end
  end
  
  def get_file
    @content = Content.find(params[:id])
    send_file @content.file.url(:original, false)
  end
end