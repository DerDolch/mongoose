class ReleasesController < ApplicationController
  
  before_filter :find_product
  
  # GET /releases
  # GET /releases.xml
  def index
    @releases = @product.releases

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @releases }
    end
  end

  # GET /releases/1
  # GET /releases/1.xml
  def show
    @release = @product.releases.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @release }
    end
  end

  # GET /releases/new
  # GET /releases/new.xml
  def new
    @release = Release.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @release }
    end
  end

  # GET /releases/1/edit
  def edit
    @release = @product.releases.find(params[:id])
  end

  # POST /releases
  # POST /releases.xml
  def create
    @release = @product.releases.build(params[:release])

    respond_to do |format|
      if @release.save
        flash[:notice] = 'Release was successfully created.'
        format.html { redirect_to(product_release_url(@product,@release)) }
        format.xml  { render :xml => @release, :status => :created, :location => @release }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @release.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /releases/1
  # PUT /releases/1.xml
  def update
    @release = @product.releases.find(params[:id])

    respond_to do |format|
      if @release.update_attributes(params[:release])
        flash[:notice] = 'Release was successfully updated.'
        format.html { redirect_to(product_release_url(@product,@release)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @release.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /releases/1
  # DELETE /releases/1.xml
  def destroy
    @release = @product.releases.find(params[:id])
    @release.destroy
    # TODO: make sure you nil all the sprints associasted to the release (pa, 14-Jan-2010)

    respond_to do |format|
      format.html { redirect_to(product_releases_url(@product)) }
      format.xml  { head :ok }
    end
  end

  protected
  
  def find_product
    @product = Product.find(params[:product_id])
  rescue ActiveRecord::RecordNotFound => e
    flash[:error] = "You access a release for an unknown project"
    redirect_to products_path
  end

end
