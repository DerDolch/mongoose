require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/products/new" do
  before(:each) do
    @product = Product.new
    @ps1 = mock_model(ProductStatus, :id => 1, :title => 'Active')
    @ps2 = mock_model(ProductStatus, :id => 2, :title => 'On Hold')
    
    @u1 = mock_model(User, :id => 1, :first_name => 'Joe', :last_name => 'Doe', :product_status_id => 1, :product_status => @ps1)
    @u2 = mock_model(User, :id => 2, :first_name => 'John', :last_name => 'Doe', :product_status_id => 2, :product_status => @ps2)
    
    @users_assigned = User.new
    assigns[:product] = @product 
    assigns[:users_list] = [@u1, @u2]
    assigns[:users_assigned] = [User.new]
    assigns[:product_statuses] = [@ps1, @ps2]

  end

  def do_render
    render 'products/new'
  end

  
  it "should have a form for creating a Product" do
    do_render
    response.should have_tag('form[action=?][method=post]', products_path) do
      with_tag('input[name=?]', 'product[name]')
      with_tag('input[name=?]', 'product[identifier]')
      with_tag('textarea[name=?]', 'product[description]')
      with_tag('input[type=submit]')
    end
  end

end
