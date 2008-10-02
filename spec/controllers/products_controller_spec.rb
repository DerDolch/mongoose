require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ProductsController do

  before(:each) do
    login_as_mock_user
    Product.stub!(:has_access?).and_return(true)    
  end

  #Delete these examples and add some real ones
  it "should use ProductsController" do
    controller.should be_an_instance_of(ProductsController)
  end


  describe "GET 'index'" do
    
    before(:each) do
      
      @product = mock_model(Product)
      Product.stub!(:find).and_return([@product])
    end
    
    def do_get
      get :index
    end
    
    it "should be successful" do
      do_get
      response.should be_success
    end
    
    it "should assign the products variable" do
      Product.should_receive(:all).and_return([@product])
      do_get
      assigns(:products).should == [@product]
    end
    
  end

  describe "GET 'show'" do
 
    before(:each) do
      
      @product_users = [mock_model(User, :id =>1 ), mock_model(User, :id =>2)]
      @product = mock_model(Product, :users => @product_users)
      # @user_status = mock_model(UserStatus, :id => 1, :name => 'Developer')
      Product.stub!(:find).and_return(@product)
      Product.stub!(:has_access?).and_return(true)
    end   
    
    it "should be redirect if the user is not assigned to the product" do
      Product.stub!(:has_access?).and_return(false)
      get 'show'
      response.should be_redirect
    end
    
    
    it "should be success if the user is assigned to the product" do
      get 'show'
      response.should be_success
    end
    
    it "should load up product from a provided id" do
      Product.should_receive(:find).with('1').and_return(@product)
      get :show, :id => 1
    end
    
    it "should assign the product variable" do
      get :show, :id => 1
      assigns(:product).should == @product
    end
    
  end

  describe "GET 'new'" do

    before(:each) do
      
      @product = mock_model(Product)
      Product.stub!(:new).and_return(@product)
      @user_list = mock_model(User)
      User.stub!(:all).and_return([@users_list])
    end   

    it "should be successful" do
      get 'new'
      response.should be_success
    end

    it "should instantiate a new product" do
      Product.should_receive(:new).and_return(@product)
      get :new
    end
    
    it "should assign a new product" do
      get :new
      assigns(:product).should == @product
    end

    it "should find a list of all users and assign variable" do
      User.should_receive(:find).and_return([@users_list])
      get :new
      assigns(:users_list).should == [@users_list]
    end
    
    it "should render the new template" do
      get :new
      response.should render_template('new')
    end
  end

  describe "POST 'create'" do
    
    before(:each) do
      
      @params = {"product"=>{"name"=>"My Product", "description"=>"THis is a fun little description.", "identifier"=>"MP2"}, "product_user" => {"user_id" => "1"}}
      @product = Product.new(@params['product'])
      @product.stub!(:save).and_return(true)
      Product.stub!(:new).and_return(@product)
    end
    
    def do_post
      post :create, @params
    end
    
    it "should instantiate a new product with POSTed params" do
      Product.should_receive(:new).with(@params['product']).and_return(@product)
      do_post
    end
    
    it "should save the new product" do
      @product.should_receive(:save).and_return(true)
      do_post
    end

    it "should redirect to the show page when saved successfully" do
      do_post
      response.should redirect_to(product_path(@product))
      flash[:notice].should == 'Product Saved'
    end

    it "should render the new page when the save fails" do
      @product.stub!(:save).and_return(false)
      do_post
      response.should render_template('new')
    end
  end

  describe "GET 'edit'" do
    before(:each) do     
      @users = [mock_model(User, :first_name => 'Joe', :last_name => 'Doe'), mock_model(User, :first_name => 'Joe', :last_name => 'Doe')]
      @product_users = [mock_model(User, :user_id => 1), mock_model(User, :user_id => 2)]
      @product = mock_model(Product, :users => @users, :product_users => @product_users)
      Product.stub!(:find).and_return(@product)
    end   

    def do_get
      get :edit, :id => '1'
    end

    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should find the product with the supplied id" do
      Product.should_receive(:find).with("1").and_return(@product)
      do_get
    end
 
    it "should find a list of all users and assign variable" do
      User.should_receive(:find).and_return([@users_list])
      do_get
      assigns(:users_list).should == [@users_list]
    end
    
    it "should assign a new product" do
      do_get
      assigns(:product).should == @product
    end
    
    it "should render the new template" do
      do_get
      response.should render_template('edit')
    end
  end

  describe "PUT 'update'" do

    before(:each) do 
      @params = {'id' => 1, "product"=>{"name"=>"My Product", "description"=>"THis is a fun little description.", "identifier"=>"MP2"}, "product_user" => {"user_id" => "1"}}
      @users = [mock_model(User, :first_name => 'Joe', :last_name => 'Doe'), mock_model(User, :first_name => 'Joe', :last_name => 'Doe')]
      @product_users = [mock_model(ProductUser), mock_model(ProductUser)]
      @product_users.stub!(:destroy_all)
      @product = mock_model(Product, :users => @users, :product_users => @product_users)
      @product.stub!(:update_attributes).and_return(true)
      Product.stub!(:find).and_return(@product)
    end

    def do_put
      put :update, @params
    end

    it "should find an existing product with the supplied id" do 
      Product.should_receive(:find).with('1').and_return(@product)
      @product_users.should_receive(:destroy_all)
      do_put
    end
    
    it "should update the product the new params" do
      @product.should_receive(:update_attributes).with(@params['product']).and_return(@product)
      do_put
    end

    it "should redirect to the show page when updated successfully" do
      do_put
      response.should redirect_to(product_path(:product_id => @product))
      flash[:notice].should == 'Product Updated'
    end

    it "should render the edit page when the updated fails" do
      @product.stub!(:update_attributes).and_return(false)
      do_put
      response.should render_template('edit')
    end
    
  end

  describe "GET 'destroy'" do
    before(:each) do
      
      @product = mock_model(Product)
      @product.stub!(:destroy).and_return(true)
      Product.stub!(:find).and_return(@product)
    end

    def do_delete
      delete :destroy, :id => '1'
    end

    it "should find an existing product with the supplied id" do
      Product.should_receive(:find).with('1').and_return(@product)
      do_delete
    end
    
    it "should update the product the new params" do
      @product.should_receive(:destroy).and_return(true)
      do_delete
    end

    it "should redirect to the index page when deleted successfully" do
      do_delete
      response.should redirect_to(products_path)
      flash[:notice].should == 'Product Deleted'
    end

    it "should render the show page when the delete fails" do
      @product.stub!(:destroy).and_return(false)
      do_delete
      response.should redirect_to(product_path(@product))
      flash[:error].should == 'Product Deletion Failed'
    end
    
  end

end
