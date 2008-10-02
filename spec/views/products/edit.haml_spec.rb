require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/products/edit" do

  before(:each) do

    @ps1 = mock_model(ProductStatus, :id => 1, :title => 'Active')
    @ps2 = mock_model(ProductStatus, :id => 2, :title => 'On Hold')

    @product = mock_model(Product, :name => 'Cat', :description => 'Animal', :identifier => 'meow', :product_status_id => 1, :product_status => @p1)
    
    @u1 = mock_model(User, :id => 1, :first_name => 'Joe', :last_name => 'Doe', :product_status_id => 1, :product_status => @ps1)
    @u2 = mock_model(User, :id => 2, :first_name => 'John', :last_name => 'Doe', :product_status_id => 2, :product_status => @ps2)

    @users_assigned = User.new
    assigns[:product] = @product 
    assigns[:users_list] = [@u1, @u2]
    assigns[:users_assigned] = [@u1, @u2]
    assigns[:product_statuses] = [@ps1, @ps2]
  end

  def do_render
    render 'products/edit'  
  end
  
  it "should have a form for creating a Product" do
    do_render
    response.should have_tag('form[action=?][method=post]', product_path(@product)) do
      with_tag('input[name=?][value=?]', 'product[name]', @product.name)
      with_tag('input[name=?][value=?]', 'product[identifier]', @product.identifier)
      with_tag('textarea[name=?]', 'product[description]', @product.description)
      with_tag('input[type=submit]')
    end
  end
end
