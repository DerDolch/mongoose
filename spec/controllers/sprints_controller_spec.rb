require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SprintsController do
  before(:each) do
    login_as_mock_user
    @product = mock_model(Product)
    Product.stub!(:find_by_id).and_return(@product)
  end


  describe "loading product" do
    before(:each) do
      @story = mock_model(Story)
      @product.stub!(:sprints).and_return([@sprint])
    end
  
    def do_get
      get :index, :product_id => '1'
    end

    it "should find the product" do
      Product.should_receive(:find_by_id).with('1').and_return(@product)
      do_get
    end
    
    it 'should assign the product' do
      do_get
      assigns[:product].should == @product
    end
    
    it 'should redirect to the products index if the product cannot be found' do
      Product.stub!(:find_by_id).and_return(nil)
      do_get
      response.should redirect_to(products_path)
    end
    
    it "should redirect to the products index if the product_id is not supplied" do
      get :index
      response.should redirect_to(products_path)
    end
  end

  describe "handling GET /sprints" do

    before(:each) do
      @s1 = mock_model(Sprint, :title => 'SprintTitle', :description => 'SprintDescr', :goal => 'Complete', :start_date => Time.now, :end_date => Time.now)
      @sprint = mock_model(Sprint)
      @product.stub!(:sprints).and_return([@sprint])
    end
  
    def do_get
      get :index, :product_id => '1'
    end
  
    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should render index template" do
      do_get
      response.should render_template('index')
    end
  
    it "should find all sprints" do
      @product.stub!(:sprints).and_return([@sprint])
      do_get
    end
  
    it "should assign the found sprints for the view" do
      do_get
      assigns[:sprints].should == [@sprint]
    end
  end

  describe "handling GET /sprints/1" do

    before(:each) do
      
      @sprint = mock_model(Sprint)
      Sprint.stub!(:find).and_return(@sprint)
    end
  
    def do_get
      get :show, :id => "1", :product_id => '1'
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should render show template" do
      do_get
      response.should render_template('show')
    end
  
    it "should find the sprint requested" do
      Sprint.should_receive(:find).with("1").and_return(@sprint)
      do_get
    end
  
    it "should assign the found sprint for the view" do
      do_get
      assigns[:sprint].should equal(@sprint)
    end
  end

  describe "handling GET /sprints/1.xml" do

    before(:each) do
      
      @sprint = mock_model(Sprint, :to_xml => "XML")
      Sprint.stub!(:find).and_return(@sprint)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :show, :id => "1", :product_id => '1'
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should find the sprint requested" do
      Sprint.should_receive(:find).with("1").and_return(@sprint)
      do_get
    end
  
    it "should render the found sprint as xml" do
      @sprint.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /sprints/new" do

    before(:each) do
      
      @sprint = mock_model(Sprint)
      Sprint.stub!(:new).and_return(@sprint)
    end
  
    def do_get
      get :new, :product_id => '1'
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should render new template" do
      do_get
      response.should render_template('new')
    end
  
    it "should create an new sprint" do
      Sprint.should_receive(:new).and_return(@sprint)
      do_get
    end
  
    it "should not save the new sprint" do
      @sprint.should_not_receive(:save)
      do_get
    end
  
    it "should assign the new sprint for the view" do
      do_get
      assigns[:sprint].should equal(@sprint)
    end
  end

  describe "handling GET /sprints/1/edit" do

    before(:each) do
      
      @sprint = mock_model(Sprint)
      Sprint.stub!(:find).and_return(@sprint)
    end
  
    def do_get
      get :edit, :id => "1", :product_id => '1'
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should render edit template" do
      do_get
      response.should render_template('edit')
    end
  
    it "should find the sprint requested" do
      Sprint.should_receive(:find).and_return(@sprint)
      do_get
    end
  
    it "should assign the found Sprint for the view" do
      do_get
      assigns[:sprint].should equal(@sprint)
    end
  end

  describe "handling POST /sprints" do

    before(:each) do
      
      @sprint = mock_model(Sprint, :to_param => "1")
      Sprint.stub!(:new).and_return(@sprint)
    end
    
    describe "with successful save" do
  
      def do_post
        @sprint.should_receive(:save).and_return(true)
        post :create, :sprint => @params, :product_id => '1'
      end
  
      it "should create a new sprint" do
        Sprint.should_receive(:new).and_return(@sprint)
        do_post
      end

      it "should redirect to the new sprint" do
        do_post
        response.should redirect_to(product_sprint_url(@product, "1"))
      end
      
    end
    
    describe "with failed save" do

      def do_post
        @sprint.should_receive(:save).and_return(false)
        post :create, :sprint => {}, :product_id => '1'
      end
  
      it "should re-render 'new'" do
        do_post
        response.should render_template('new')
      end
      
    end
  end

  describe "handling PUT /sprints/1" do

    before(:each) do
      
      @sprint = mock_model(Sprint, :to_param => "1")
      Sprint.stub!(:find).and_return(@sprint)
    end
    
    describe "with successful update" do

      def do_put
        @sprint.should_receive(:update_attributes).and_return(true)
        put :update, :id => "1", :product_id => '1'
      end

      it "should find the sprint requested" do
        Sprint.should_receive(:find).with("1").and_return(@sprint)
        do_put
      end

      it "should update the found sprint" do
        do_put
        assigns(:sprint).should equal(@sprint)
      end

      it "should assign the found sprint for the view" do
        do_put
        assigns(:sprint).should equal(@sprint)
      end

      it "should redirect to the sprint" do
        do_put
        response.should redirect_to(product_sprint_url(@product, "1"))
      end

    end
    
    describe "with failed update" do

      def do_put
        @sprint.should_receive(:update_attributes).and_return(false)
        put :update, :id => "1", :product_id => '1'
      end

      it "should render an eddor message" do
        do_put
      end

    end
  end

  describe "handling DELETE /sprints/1" do

    before(:each) do
      @sprint = mock_model(Sprint, :destroy => true)
      Sprint.stub!(:find).and_return(@sprint)
    end
  
    def do_delete
      delete :destroy, :id => "1", :product_id => '1'
    end

    it "should find the sprint requested" do
      Sprint.should_receive(:find).with("1").and_return(@sprint)
      do_delete
    end
  
    it "should call destroy on the found sprint" do
      @sprint.should_receive(:destroy)
      do_delete
    end
  
    it "should redirect to the sprints list" do
      do_delete
      response.should redirect_to(product_path(@product))
    end
  end
end
