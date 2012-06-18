class Spree::Admin::PricingPlansController < Spree::Admin::ResourceController
  # GET /pricing_plans
  # GET /pricing_plans.xml
  #~ resource_controller
  before_filter :find_pricing_plan, :only => [:show,:edit,:update,:destroy]

  def index
    @search =Spree::PricingPlan.ransack(params[:search])
    #~ @pricing_plans = @search#.all.paginate(:per_page => Spree::Config[:admin_products_per_page], :page => params[:page])
    a=@search.object
    @pricing_plans = a

    #~ p @pricing_plans
    #~ p @pricing_plans.object
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pricing_plans }
    end
  end

  # GET /pricing_plans/1
  # GET /pricing_plans/1.xml

  def show
    find_pricing_plan
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @pricing_plan }
    end
  end

  # GET /pricing_plans/new
  # GET /pricing_plans/new.xml

  def new
    @pricing_plan =Spree::PricingPlan.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @pricing_plan }
    end
  end

  # GET /pricing_plans/1/edit

  def edit
    find_pricing_plan
  end

  # POST /pricing_plans
  # POST /pricing_plans.xml

  def create
    @pricing_plan = Spree::PricingPlan.new(params[:pricing_plan])
    respond_to do |format|
      if @pricing_plan.save
        format.html { redirect_to(admin_pricing_plan_path(@pricing_plan), :notice => 'Pricing plan was successfully created.') }
        format.xml  { render :xml => @pricing_plan, :status => :created, :location => @pricing_plan }
      else
        format.html { render  "new" }
        format.xml  { render :xml => @pricing_plan.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pricing_plans/1
  # PUT /pricing_plans/1.xml

  def update
    find_pricing_plan
    respond_to do |format|
      if @pricing_plan.update_attributes(params[:pricing_plan])
        format.html { redirect_to(admin_pricing_plan_path(@pricing_plan), :notice => 'Pricing plan was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render  "edit" }
        format.xml  { render :xml => @pricing_plan.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pricing_plans/1
  # DELETE /pricing_plans/1.xml

  def destroy
    find_pricing_plan
    @pricing_plan.destroy
    respond_to do |format|
      format.html { redirect_to(admin_pricing_plans_url,:notice=>"Pricing plan was successfully destroyed") }
      format.xml  { head :ok }
    end
  end

  def find_pricing_plan
    @pricing_plan = Spree::PricingPlan.find(params[:id])
  end
end
