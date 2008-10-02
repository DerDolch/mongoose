require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe StoriesController do
  before(:each) do
    login_as_mock_user
    @product = mock_model(Product)
    Product.stub!(:find_by_id).and_return(@product)
  end
  
  describe "loading product" do
    before(:each) do
      @story = mock_model(Story)
      Story.stub!(:find).and_return([@story])
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
  
  
  describe "handling GET /stories" do

    before(:each) do
      @story = mock_model(Story)
      Story.stub!(:find).and_return([@story])
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
  
    it "should find all stories" do
      Story.should_receive(:find).with(:all).and_return([@story])
      do_get
    end
  
    it "should assign the found stories for the view" do
      do_get
      assigns[:stories].should == [@story]
    end
  end

  describe "handling GET /stories.xml" do

    before(:each) do
      login_as_mock_user
      @stories = mock("Array of Stories", :to_xml => "XML")
      Story.stub!(:find).and_return(@stories)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :index, :product_id => '1'
    end
  
    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should find all stories" do
      Story.should_receive(:find).with(:all).and_return(@stories)
      do_get
    end
  
    it "should render the found stories as xml" do
      @stories.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /stories/1" do

    before(:each) do
      login_as_mock_user
      @story = mock_model(Story)
      @tasks = mock_model(Task)
      Story.stub!(:find).and_return(@story)
      
      @story.should_receive(:tasks).and_return(@tasks)
      @story.should_receive(:product).and_return(@product)
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
  
    it "should find the story requested" do
      Story.should_receive(:find).with("1").and_return(@story)
      do_get
    end
  
    it "should assign the found story for the view" do
      do_get
      assigns[:story].should equal(@story)
    end
  end

  describe "handling GET /stories/1.xml" do

    before(:each) do
      login_as_mock_user
      @tasks = mock_model(Task)
      @story = mock_model(Story, :to_xml => "XML")
      Story.stub!(:find).and_return(@story)
      
      @story.should_receive(:tasks).and_return(@tasks)
      @story.should_receive(:product).and_return(@product)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :show, :id => "1", :product_id => '1'
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should find the story requested" do
      Story.should_receive(:find).with("1").and_return(@story)
      do_get
    end
  
    it "should render the found story as xml" do
      @story.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /stories/new" do

    before(:each) do
      login_as_mock_user
      @story = mock_model(Story)
      Story.stub!(:new).and_return(@story)
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
  
    it "should create an new story" do
      Story.should_receive(:new).and_return(@story)
      do_get
    end
  
    it "should not save the new story" do
      @story.should_not_receive(:save)
      do_get
    end
  
    it "should assign the new story for the view" do
      do_get
      assigns[:story].should equal(@story)
    end
  end

  describe "handling GET /stories/1/edit" do

    before(:each) do
      login_as_mock_user
      @story = mock_model(Story)
      Story.stub!(:find).and_return(@story)
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
  
    it "should find the story requested" do
      Story.should_receive(:find).and_return(@story)
      do_get
    end
  
    it "should assign the found Story for the view" do
      do_get
      assigns[:story].should equal(@story)
    end
  end

  describe "handling POST /stories" do

    before(:each) do
      login_as_mock_user
      @story = mock_model(Story, :to_param => "1")
      Story.stub!(:new).and_return(@story)
    end
    
    describe "with successful save" do
  
      def do_post
        @story.should_receive(:save).and_return(true)
        post :create, :story => {}, :product_id => '1'
      end
  
      it "should create a new story" do
        Story.should_receive(:new).with({}).and_return(@story)
        do_post
      end

      it "should redirect to the new story" do
        do_post
        response.should redirect_to(product_story_url(@product, @story))    
      end
      
    end
    
    describe "with failed save" do

      def do_post
        @story.should_receive(:save).and_return(false)
        post :create, :story => {}, :product_id => '1'
      end
  
      it "should re-render 'new'" do
        do_post
        response.should render_template('new')
      end
      
    end
  end

  describe "handling PUT /stories/1" do

    before(:each) do
      login_as_mock_user
      @story = mock_model(Story, :to_param => "1")
      Story.stub!(:find).and_return(@story)
    end
    
    describe "with successful update" do

      def do_put
        @story.should_receive(:update_attributes).and_return(true)
        put :update, :id => "1", :product_id => '1'
      end

      it "should find the story requested" do
        Story.should_receive(:find).with("1").and_return(@story)
        do_put
      end

      it "should update the found story" do
        do_put
        assigns(:story).should equal(@story)
      end

      it "should assign the found story for the view" do
        do_put
        assigns(:story).should equal(@story)
      end

      it "should redirect to the story" do
        do_put
        response.should redirect_to(product_story_url(@product, "1"))

      end

    end
    
    describe "with failed update" do

      def do_put
        @story.should_receive(:update_attributes).and_return(false)
        put :update, :id => "1", :product_id => '1'
      end

      it "should re-render 'edit'" do
        do_put
        response.should render_template('edit')
      end

    end
  end

  describe "handling DELETE /stories/1" do

    before(:each) do
      login_as_mock_user
      @story = mock_model(Story, :destroy => true)
      Story.stub!(:find).and_return(@story)
    end
  
    def do_delete
      delete :destroy, :id => "1", :product_id => '1'
    end

    it "should find the story requested" do
      Story.should_receive(:find).with("1").and_return(@story)
      do_delete
    end
  
    it "should call destroy on the found story" do
      @story.should_receive(:destroy)
      do_delete
    end
  
    it "should redirect to the stories list" do
      do_delete
      response.should redirect_to(product_stories_url(@product))
    end
  end
end