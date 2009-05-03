class TasksController < ApplicationController

  before_filter :find_product, :find_story
  protect_from_forgery :only => [:create, :update, :destroy]

  # GET /tasks
  # GET /tasks.xml
  def index
    @tasks = Task.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tasks }
    end
  end

  # GET /tasks/1
  # GET /tasks/1.xml
  def show 
    @task = Task.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @task }
    end
  end

  # GET /tasks/new
  # GET /tasks/new.xml
  def new
    @task = Task.new

    if params[:id].blank?
      # @story = Story.find(:all)
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @task }
    end
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
  end

  # POST /tasks
  # POST /tasks.xml
  def create
    @task = Task.new(params[:task])

    respond_to do |format|
      if @task.save
        flash[:notice] = 'Task was successfully created.'
        format.html { redirect_to product_story_task_path(@product, @story, @task) }
        format.xml  { render :xml => @task, :status => :created, :location => @task }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.xml
  def update
    @task = Task.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(params[:task])
        flash[:notice] = 'Task was successfully updated.'
        format.html { redirect_to product_story_task_path(@product, @story, @task) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update_task_status
    task_id = params[:task_id]
    task_status_id = params[:task_status_id]
    task = Task.find(task_id)
    task.update_attributes(:task_status_id => task_status_id)
    
    respond_to do |format|
      format.js {}
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    respond_to do |format|
      format.html { redirect_to( product_story_tasks_path) }
      format.xml  { head :ok }
    end
  end

protected
  
  def find_product
    @product = Product.find_by_id(params[:product_id]) unless params[:product_id].blank?
    redirect_to products_path if @product.blank?
  end

  def find_story
    @story = Story.find_by_id(params[:story_id]) unless params[:story_id].blank?
    redirect_to product_stories_path(@product) if @story.blank?
  end

end
