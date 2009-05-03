class StoriesController < ApplicationController
  
  before_filter :find_product
  protect_from_forgery :only => [:create, :update, :destroy]
  
  # GET /products/1/stories => product_stories_url(@product)
  # GET /stories.xml
  def index
    @stories = Story.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @stories }
    end
  end

  # GET /stories/1
  # GET /stories/1.xml
  def show
    @story = Story.find(params[:id])
    @tasks = @story.tasks
    @new_task = Task.new
    @product = @story.product

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @story }
    end
  end

  # GET /stories/new
  # GET /stories/new.xml
  def new
    @story = Story.new
    @sprints = Sprint.new
    @products = Product.find(:all, :select => "id, name")
    @sprints = Sprint.find(:all, :select => 'id, title')

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @story }
    end
  end

  # GET /stories/1/edit
  def edit
    @story = Story.find(params[:id])
  end

  # POST /stories
  # POST /stories.xml
  def create
    
    @story = Story.new(params[:story])

    respond_to do |format|
      if @story.save
        flash[:notice] = 'Story was successfully created.'
        format.html { redirect_to product_story_url(@product,@story) }
        format.xml  { render :xml => @story, :status => :created, :location => @story }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @story.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /stories/1
  # PUT /stories/1.xml
  def update
    @story = Story.find(params[:id])

    respond_to do |format|
      if @story.update_attributes(params[:story])
        flash[:notice] = 'Story was successfully updated.'
        format.html { redirect_to product_story_url(@product,@story) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @story.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update_order
    params[:update_sort_table].each do |story_id,position|
      story = Story.find(story_id)
      story.insert_at(position)
    end
  end

  def update_sprint_assoc
    sprint_id = params[:sprint_id]
    story = Story.find(params[:story_id])
    story.update_attributes(:sprint_id => sprint_id)
    respond_to do |format|
      format.js {}
    end
  end

  # DELETE /stories/1
  # DELETE /stories/1.xml
  def destroy
    @story = Story.find(params[:id])
    @story.destroy

    respond_to do |format|
      format.html { redirect_to(product_stories_url(@product)) }
      format.xml  { head :ok }
    end
  end

  protected
  
  def find_product
    @product = Product.find_by_id(params[:product_id]) unless params[:product_id].blank?
    redirect_to products_path if @product.blank?
  end

end
