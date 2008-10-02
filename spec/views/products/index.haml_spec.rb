require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/products/index" do
  before(:each) do
    @p1 = mock_model(Product, :name => 'Scrum', :description => 'My Scrum', :identifier => 'MS', :product_status_id => 1, :product_status => mock_model(ProductStatus, :id => '1', :title => 'active'))
    @p2 = mock_model(Product, :name => 'TextMate', :description => 'My Editor', :identifier => 'TXTMT', :product_status_id => 1, :product_status => mock_model(ProductStatus, :id => '1', :title => 'active'))
    assigns[:products] = [@p1,@p2]
    
  end

  def do_render
    render 'products/index'
  end
  

  
  it "should list out all products" do
    do_render 
    response.should have_tag('dl[id=product]') do
      with_tag("dt a[href=#{product_path(@p1)}]", "#{@p1.name} [#{@p1.identifier}] (#{@p1.product_status.title})")
      
      
      with_tag('dd', "Description:\n      #{@p1.description}")

      with_tag("dt a[href=#{product_path(@p2)}]", "#{@p2.name} [#{@p2.identifier}] (#{@p2.product_status.title})")
      with_tag('dd', "Description:\n      #{@p2.description}")

    end
  end
  
  it "should display a message when no products are available" do
    assigns[:products] = []
    do_render
    response.should have_tag('p','No Products Available')
  end
end
