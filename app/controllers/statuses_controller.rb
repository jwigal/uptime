class StatusesController < ApplicationController
  # GET /statuses
  # GET /statuses.xml
  load_and_authorize_resource
  
  def index
    respond_to do |format|
      format.any(:html, :rss) do
        @statuses = Status.order("statuses.updated_at desc").where(["statuses.updated_at >= ?", 14.days.ago])
        @statuses = @statuses.for_public unless current_user 
        @statuses = @statuses.group_by(&:formatted_date) unless request.format.to_sym == :rss
        @services = Service.order("name")
        # @history = Status.where(["statuses.updated_at >= ?", 1.year.ago]).all
        @uptime = {3 => Outage.uptime(3.months.ago) * 100.0}
        @uptime[6] = Outage.uptime( 6.months.ago) * 100.0
        @uptime[12] = Outage.uptime( 12.months.ago) * 100.0
        
#        @dates = Status.select("year(created_at) year, month(created_at) month").group("year(created_at), month(created_at)")
      end
      format.js do 
        @time_zone = ActiveSupport::TimeZone[params[:zone]] || ActiveSupport::TimeZone["UTC"]
      end
    end
  end

  # GET /statuses/1
  # GET /statuses/1.xml
  def show
    @status = Status.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @status }
    end
  end

  # GET /statuses/new
  # GET /statuses/new.xml
  def new
    @status = Status.new
    @categories = Category.order("name")
    @services = Service.order("name")
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @status }
    end
  end

  # GET /statuses/1/edit
  def edit
    @status = Status.find(params[:id])
    @categories = Category.order("name")
    @services = Service.order("name")
  end

  # POST /statuses
  # POST /statuses.xml
  def create
    @status = Status.new(params[:status])
    @categories = Category.order("name")
    @services = Service.order("name")

    respond_to do |format|
      if @status.save
        format.html { redirect_to(statuses_path, :notice => 'Status was successfully created.') }
        format.xml  { render :xml => @status, :status => :created, :location => @status }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @status.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /statuses/1
  # PUT /statuses/1.xml
  def update
    @status = Status.find(params[:id])
    @categories = Category.order("name")
    @services = Service.order("name")

    respond_to do |format|
      if @status.update_attributes(params[:status])
        format.html { redirect_to(statuses_path, :notice => 'Status was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @status.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /statuses/1
  # DELETE /statuses/1.xml
  def destroy
    @status = Status.find(params[:id])
    @status.destroy

    respond_to do |format|
      format.html { redirect_to(statuses_url) }
      format.xml  { head :ok }
    end
  end
end
