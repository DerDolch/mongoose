require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ProductStatus do
  before(:each) do
    @product_status = ProductStatus.new
  end

  it "should be valid" do
    @product_status.should be_valid
  end
end
