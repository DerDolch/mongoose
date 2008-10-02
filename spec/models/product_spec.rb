require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Product do
  before(:each) do
    @product = Product.new
  end

  describe "validations" do
    before(:each) do
      @product.valid?
    end
  
    it "should validate the name exists" do
      @product.should have(2).errors_on(:name)
    end

    it "should validate the name to be at least 5 characters long" do
      @product.name = 'moo!'
      @product.should have(1).errors_on(:name)      
    end

    it "should validate the description exists" do
      @product.should have(1).error_on(:description)
    end

    it "should validate the identifier exists" do
      @product.should have(1).error_on(:identifier)
    end

  end

end
