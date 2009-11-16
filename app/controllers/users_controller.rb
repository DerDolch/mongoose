class UsersController < ApplicationController
  skip_before_filter :login_required, :only => [:create, :new]
  before_filter :check_if_user_is_developer, :only => [:index, :show, :edit, :destroy]

  # GET /users
  def index
    @users = User.find(:all)

  end

  # GET /users/1
  def show
    @user = current_user
  end


  # render new.rhtml
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end
 
  # POST/users
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Thanks for signing up!"
      redirect_back_or_default('/')
    else
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
      render :action => 'new'
    end
  end

  # PUT /users/1
  def update
     @user = User.find(params[:id])

     if @user.update_attributes(params[:user])
       flash[:notice] = 'Users Updated'
       redirect_to users_path
     else
       render :action => :edit
     end
  end

  
  def destroy
    
    User.find(params[:id]).destroy

    respond_to do |format|
      format.html { redirect_to(users_path) }
      format.xml  { head :ok }
    end 
  end

protected 

  def check_if_user_is_developer
    redirect_to products_path if current_user.status == "Developer"
  end
 
end
