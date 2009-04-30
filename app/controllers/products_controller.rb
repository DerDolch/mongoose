class ProductsController < ApplicationController

  require_role 'Admin', :for_all_except => [:index, :show]
  
  def index
    if current_user.user_status.name == "Developer"
      @products = Product.find(:all, :include => :users, :conditions => ['users.id=? AND product_status_id IN (?)', current_user.id, 0..2])
    else
      @products = Product.all
    end

  end

  def show
    begin
      @product = Product.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error("Attempt to access invalid product #{params[:id]}]")
      flash[:notice] = "Invalid Product"
      redirect_to products_path
    else
      @active_sprints = Sprint.find_sprints_from_id_and_status(params[:id], 1)
      @completed_sprints = Sprint.find_sprints_from_id_and_status(params[:id], 2)
      @story_backlog = Story.find_story_backlog_from_id(@product.id)
      
      if current_user.user_status.name == "Developer"
        @mode = nil
      else
        @mode = params[:mode] || 'sortable'
      end
    
    end
  end

  def new
    @product = Product.new
    @users_list = User.find(:all) # TODO: calling this "users" would be more standard
    @users_assigned = []
    @product_statuses = ProductStatus.all
  end

  def create
    @product = Product.new(params[:product])
    @users_list = User.find(:all)
    @users_assigned = []
    @product_statuses = ProductStatus.all
     
    if @product.save
      unless params[:product_user][:user_id].blank?
        params[:product_user][:user_id].each {|u| ProductUser.create(:product_id => @product.id, :user_id => u)}
      end
      flash[:notice] = 'Product Saved'
      redirect_to product_path(@product)
    else
      render :action => :new
    end
  end

  def edit
    @product = Product.find(params[:id])
    @product_statuses = ProductStatus.all

    @users_assigned = @product.users
    @users_list = User.find(:all)
    @users_list = @users_list - @users_assigned
  end

  def update
    @product = Product.find(params[:id])
    @product_statuses = ProductStatus.find(:all)

    @users_list = User.find(:all)
    if @product.update_attributes(params[:product])
      
      @product.product_users.destroy_all
 
      unless params[:product_user][:user_id].blank?
        params[:product_user][:user_id].each {|u| ProductUser.create(:product_id => @product.id, :user_id => u)}
      end

      flash[:notice] = 'Product Updated'
      redirect_to product_path(:product_id => @product)
    else
      render :action => :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product_statuses = ProductStatus.all
    if @product.destroy 
      flash[:notice] = 'Product Deleted'
      redirect_to products_path 
    else
      flash[:error] = 'Product Deletion Failed'
      redirect_to product_path(@product)    
    end
  end

end
