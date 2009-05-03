require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/products/show" do
  before(:each) do
    
    @user = mock_model(User, :status => "Active", :first_name => "John", :last_name => "Doe", :login => "johndoe")
    template.stub!(:current_user).and_return(@user)
    
    @sprint = mock_model(Sprint, valid_sprint_attributes)
    @sprint_proxy = mock('SprintProxy', :active => [@sprint], :completed => [@sprint])

    @backlog_story = mock_model(Story, valid_story_attributes(:title => 'backlog', :effort => 8, :description => 'Not yet'))
    @story = mock_model(Story, valid_story_attributes)
    @story_proxy = mock('StoryProxy', :unassigned => [@story,@backlog_story])
    
    @product = mock_model(Product,valid_product_attributes)
    @product.stub!(:stories).and_return(@story_proxy)
    @product.stub!(:sprints).and_return(@sprint_proxy)
        
    assigns[:product] = @product

  end

  def do_render
    render 'products/show'
  end
  
  it "should have a link to edit this item" do
    do_render
    response.should have_tag("a[href=#{edit_product_path(@product)}]", 'Edit Product')
  end

  it "should have a link to return to the product listing page" do
    do_render
    response.should have_tag("a[href=#{products_path}]", 'Products')
  end

  it "should have a link to remove this item" do
    do_render
    response.should have_tag("a[href=?][onclick=?]", product_path(@product), /.+/, 'Remove Product')
  end
  
  it "should list all stories in current sprint with edit / remove" do
    do_render

    response.should have_tag("tbody>tr>td a")
    response.should have_tag('tbody>tr>td', @story.description)
    response.should have_tag('tbody>tr>td', @story.effort.to_s)    
  end
  
  it "it should display a message if there are no stories in current sprint" do
    assigns[:sprint_current_stories] = []
    do_render
  end

  it "should list all stories in backlog that are not assigned to a sprint" do
    do_render
    response.should have_tag("tbody>tr>td a")
    response.should have_tag('tbody>tr>td', @backlog_story.description)
    response.should have_tag('tbody>tr>td', @backlog_story.effort.to_s)
  end

end
