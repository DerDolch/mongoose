class SprintsController < ApplicationController
  
  #require_role 'Admin', :for_all_except => [:index, :show]
  before_filter :find_product
  
  # GET /sprints
  # GET /sprints.xml
  def index
    @sprints = @product.sprints

   respond_to do |format|
     format.html # index.html.erb
    format.xml  { render :xml => @sprints }
   end
  end

  # GET /sprints/1
  # GET /sprints/1.xml
  def show
    @sprint = Sprint.find(params[:id])
    @stories = Story.find_story_list_from_sprint_id(@sprint)

    @mode = params[:mode] || 'sortable'

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sprint }
    end
  end

  # GET /sprints/new
  # GET /sprints/new.xml
  def new
    @sprint = Sprint.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sprint }
    end
  end

  # GET /sprints/1/edit
  def edit
    @sprint = Sprint.find(params[:id])
  end

  # POST /sprints
  # POST /sprints.xml
  def create
    @sprint = Sprint.new(params[:sprint])

    respond_to do |format|
      if @sprint.save
        flash[:notice] = 'Sprint was successfully created.'
        format.html { redirect_to product_sprint_path(@product, @sprint) }
        format.xml  { render :xml => @sprint, :status => :created, :location => @sprint }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sprint.errors, :status => :unprocessable_entity }
      end
    end

  end

  # PUT /sprints/1
  # PUT /sprints/1.xml
  def update
    @sprint = Sprint.find(params[:id])

    respond_to do |format|
 
      if @sprint.update_attributes(params[:sprint])
        flash[:notice] = 'Sprint was successfully updated.'
        format.html { redirect_to product_sprint_path(@product, @sprint) }
        format.xml  { head :ok }
      else
        format.html { redirect_to edit_product_sprint_path(@product, @sprint) }
        format.xml  { render :xml => @sprint.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sprints/1
  # DELETE /sprints/1.xml
  def destroy
    @sprint = Sprint.find(params[:id])
    @sprint.destroy

    respond_to do |format|
      format.html { redirect_to product_path(@product) }
      format.xml  { head :ok }
    end
  end

protected
  
  def find_product
    @product = Product.find_by_id(params[:product_id]) unless params[:product_id].blank?
    redirect_to products_path if @product.blank?
  end
end