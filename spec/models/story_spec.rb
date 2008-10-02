require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Story do
  before(:each) do
    @story = Story.new
  end

  describe "validations" do
    before(:each) do
      @story.valid?
    end
  
    it "should validate the title exists" do
      @story.should have(2).error_on(:title)
    end

    it "should validate the title to be at least 5 characters long" do
      @story.title = 'moo!'
      @story.should have(1).error_on(:title)      
    end

    it "should validate the description exists" do
      @story.should have(1).error_on(:description)
    end

  end
end
