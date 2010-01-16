require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ReleasesController do

  before(:each) do
    login
    @release_proxy = mock('ReleaseAssoc')
    @product = mock_model(Product, :releases => @release_proxy)
    Product.stub!(:find).and_return(@product)
  end

  def mock_release(stubs={})
    @mock_release ||= mock_model(Release, stubs)
  end

  describe "GET index" do
    it "assigns all releases as @releases" do
      # @release_proxy.stub!(:find).with(:all).and_return([mock_release])
      get :index, :product_id => 1
      assigns[:releases].should == @release_proxy
    end
  end

  describe "GET show" do
    it "assigns the requested release as @release" do
      @release_proxy.stub!(:find).with("37").and_return(mock_release)
      get :show, :product_id => 1, :id => "37"
      assigns[:release].should equal(mock_release)
    end
  end

  describe "GET new" do
    it "assigns a new release as @release" do
      Release.stub!(:new).and_return(mock_release)
      get :new, :product_id => 1
      assigns[:release].should equal(mock_release)
    end
  end

  describe "GET edit" do
    it "assigns the requested release as @release" do
      @release_proxy.stub!(:find).with("37").and_return(mock_release)
      get :edit, :product_id => 1, :id => "37"
      assigns[:release].should equal(mock_release)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created release as @release" do
        @release_proxy.stub!(:build).with({'these' => 'params'}).and_return(mock_release(:save => true))
        post :create, :product_id => 1, :release => {:these => 'params'}
        assigns[:release].should equal(mock_release)
      end

      it "redirects to the created release" do
        @release_proxy.stub!(:build).and_return(mock_release(:save => true))
        post :create, :release => {}
        response.should redirect_to(product_release_url(@product,mock_release))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved release as @release" do
        @release_proxy.stub!(:build).with({'these' => 'params'}).and_return(mock_release(:save => false))
        post :create, :product_id => 1, :release => {:these => 'params'}
        assigns[:release].should equal(mock_release)
      end

      it "re-renders the 'new' template" do
        @release_proxy.stub!(:build).and_return(mock_release(:save => false))
        post :create, :product_id => 1, :release => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested release" do
        @release_proxy.should_receive(:find).with("37").and_return(mock_release)
        mock_release.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :product_id => 1, :id => "37", :release => {:these => 'params'}
      end

      it "assigns the requested release as @release" do
        @release_proxy.stub!(:find).and_return(mock_release(:update_attributes => true))
        put :update, :product_id => 1, :id => "1"
        assigns[:release].should equal(mock_release)
      end

      it "redirects to the release" do
        @release_proxy.stub!(:find).and_return(mock_release(:update_attributes => true))
        put :update, :product_id => 1, :id => "1"
        response.should redirect_to(product_release_url(@product, mock_release))
      end
    end

    describe "with invalid params" do
      it "updates the requested release" do
        @release_proxy.should_receive(:find).with("37").and_return(mock_release)
        mock_release.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :product_id => 1, :id => "37", :release => {:these => 'params'}
      end

      it "assigns the release as @release" do
        @release_proxy.stub!(:find).and_return(mock_release(:update_attributes => false))
        put :update, :product_id => 1, :id => "1"
        assigns[:release].should equal(mock_release)
      end

      it "re-renders the 'edit' template" do
        @release_proxy.stub!(:find).and_return(mock_release(:update_attributes => false))
        put :update, :product_id => 1, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested release" do
      @release_proxy.should_receive(:find).with("37").and_return(mock_release)
      mock_release.should_receive(:destroy)
      delete :destroy, :product_id => 1, :id => "37"
    end

    it "redirects to the releases list" do
      @release_proxy.stub!(:find).and_return(mock_release(:destroy => true))
      delete :destroy, :product_id => 1, :id => "1"
      response.should redirect_to(product_releases_url(@product))
    end
  end

end
