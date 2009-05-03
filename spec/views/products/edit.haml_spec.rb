require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/products/edit" do

  before(:each) do

    @product = mock_model(Product, valid_product_attributes)
    
    @u1 = mock_model(User, :id => 1, :first_name => 'Joe', :last_name => 'Doe', :statua => 'Active')
    @u2 = mock_model(User, :id => 2, :first_name => 'John', :last_name => 'Doe', :status => 'Active')

    @users_assigned = User.new
    assigns[:product] = @product 
    assigns[:users_list] = [@u1, @u2]
    assigns[:users_assigned] = [@u1, @u2]
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
