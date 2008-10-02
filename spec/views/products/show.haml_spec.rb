require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/products/show" do
  before(:each) do
    @mode = 'sortable'
        
    @p1 = mock_model(Product, :name => 'Test', :description => 'Hello World', :identifier => 'HIWLD', :product_status_id => 1, :product_status => mock_model(ProductStatus, :id => 1, :title => 'Active'))
    @p2 = mock_model(Product, :name => 'Test', :description => 'Hello World', :identifier => 'HIWLD', :product_status_id => 2, :product_status => mock_model(ProductStatus, :id => 2, :title => 'Active'))

    @cs1 = mock_model(Sprint, :goal => 'Take it easy', :title => 'Sprint #2', :product_id => '1',
    :start_date => Time.now, :end_date => Time.now)

    @scs1 = mock_model(Story, :sprint_id => 1, :title => 'Current Story 1', :product_id => 2, :effort => '12', :description => 'ipsum')
    @scs2 = mock_model(Story, :sprint_id => 2, :title => 'Current Story 2', :product_id => 3, :effort => '12', :description => 'ipsum')
    
    @sb1 = mock_model(Story, :sprint_id => 3, :title => 'BackLog Story 2', :product_id => 5, :effort => '12', :description => 'ipsum')
    @sb2 = mock_model(Story, :sprint_id => 4, :title => 'BackLog Story 2', :product_id => 6, :effort => '12', :description => 'ipsum')
    
    @sprint_one_active = mock_model(Sprint, :title => 'SprintTitle', :goal => 'SprintText', :start_date => Time.now, :end_date => 3.weeks.from_now,
    :sprint_status_id => 1, :sprint_status => mock_model(SprintStatus, :title => 'Open', :id => 1))

    @sprint_two_active = mock_model(Sprint, :title => 'SprintTitle', :goal => 'SprintText', :start_date => Time.now, :end_date => 3.weeks.from_now,
    :sprint_status_id => 1, :sprint_status => mock_model(SprintStatus, :title => 'Open', :id => 1))


    @sprint_one_completed = mock_model(Sprint, :title => 'SprintTitle', :goal => 'SprintText', :start_date => Time.now, :end_date => 3.weeks.from_now,
    :sprint_status_id => 2, :sprint_status => mock_model(SprintStatus, :title => 'Completed', :id => 2))
    @sprint_two_completed = mock_model(Sprint, :title => 'SprintTitle', :goal => 'SprintText', :start_date => Time.now, :end_date => 3.weeks.from_now,
    :sprint_status_id => 2, :sprint_status => mock_model(SprintStatus, :title => 'Completed', :id => 2))


    @cuser = mock_model(User, :user_status_id => 3, :first_name => "John", :last_name => "Doe", :login => "johndoe",
    :user_status => mock_model(UserStatus, :name => "Super User", :id => 3))

    assigns[:mode] = @mode    
    assigns[:current_user] = @cuser    
    assigns[:product] = @p1
    assigns[:current_sprint] = @cs1
    assigns[:sprint_current_stories] = [@scs1, @scs2] 

    assigns[:active_sprints] = [@sprint_one_active, @sprint_two_active]
    assigns[:completed_sprints] = [@sprint_one_completed, @sprint_two_completed]
    assigns[:story_backlog] = [@sb1, @sb2]


  end

  def do_render
    render 'products/show'
  end
  
  it "should have a link to edit this item" do
    do_render
    response.should have_tag("a[href=#{edit_product_path(@p1)}]", 'Edit Product')
  end

  it "should have a link to return to the product listing page" do
    do_render
    response.should have_tag("a[href=#{products_path}]", 'Products')
  end

  it "should have a link to remove this item" do
    do_render
    response.should have_tag("a[href=?][onclick=?]", product_path(@p1), /.+/, 'Remove Product')
  end
  
  it "should list all stories in current sprint with edit / remove" do
    do_render

    # scs 1
    response.should have_tag("tbody>tr>td a")
    response.should have_tag('tbody>tr>td', @scs1.description)
    response.should have_tag('tbody>tr>td', @scs1.effort)
    
    #scs 2
    response.should have_tag("tbody>tr>td a")
    response.should have_tag('tbody>tr>td', @scs2.description)
    response.should have_tag('tbody>tr>td', @scs2.effort)
  end
  
  it "it should display a message if there are no stories in current sprint" do
    assigns[:sprint_current_stories] = []
    do_render
  end

  it "should list all stories in backlog that are not assigned to a sprint" do
    do_render
    # sb 1
    response.should have_tag("tbody>tr>td a")
    response.should have_tag('tbody>tr>td', @sb1.description)
    response.should have_tag('tbody>tr>td', @sb1.effort)
    
    # b 2
    response.should have_tag("tbody>tr>td a")
    response.should have_tag('tbody>tr>td', @sb2.description)
    response.should have_tag('tbody>tr>td', @sb2.effort)
  end

end
