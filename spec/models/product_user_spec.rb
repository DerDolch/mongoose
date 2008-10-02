require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ProductUser do
  before(:each) do
    @product_user = ProductUser.new
  end

  it "should be valid" do
    @product_user.should be_valid
  end
end
