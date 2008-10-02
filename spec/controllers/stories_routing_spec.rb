require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe StoriesController do
  describe "route generation" do

    it "should map { :controller => 'stories', :action => 'index', :product_id => '1' } to /products/1/stories" do
      route_for(:controller => "stories", :action => "index", :product_id => '1').should == "/products/1/stories"
    end

    it "should map { :controller => 'stories', :action => 'new', :product_id => '1' } to /products/1/stories/new" do
      route_for(:controller => "stories", :action => "new", :product_id => '1').should == "/products/1/stories/new"
    end
  
    it "should map { :controller => 'stories', :action => 'show', :product_id => '1', :id => 1 } to /products/1/stories/1" do
      route_for(:controller => "stories", :action => "show", :product_id => '1', :id => 1).should == "/products/1/stories/1"
    end
  
    it "should map { :controller => 'stories', :action => 'edit', :product_id => '1', :id => 1 } to /products/1/stories/1/edit" do
      route_for(:controller => "stories", :action => "edit", :product_id => '1', :id => 1).should == "/products/1/stories/1/edit"
    end
  
    it "should map { :controller => 'stories', :action => 'update', :product_id => '1', :id => 1} to /products/1/stories/1" do
      route_for(:controller => "stories", :action => "update", :product_id => '1', :id => 1).should == "/products/1/stories/1"
    end
  
    it "should map { :controller => 'stories', :action => 'destroy', :product_id => '1', :id => 1} to /products/1/stories/1" do
      route_for(:controller => "stories", :action => "destroy", :product_id => '1', :id => 1).should == "/products/1/stories/1"
    end
  end

  describe "route recognition" do

    it "should generate params { :controller => 'stories', action => 'index' } from GET /products/1/stories" do
      params_from(:get, "/products/1/stories").should == {:controller => "stories", :action => "index", :product_id => '1'}
    end
  
    it "should generate params { :controller => 'stories', action => 'new' } from GET /products/1/stories/new" do
      params_from(:get, "/products/1/stories/new").should == {:controller => "stories", :action => "new", :product_id => '1'}
    end
  
    it "should generate params { :controller => 'stories', action => 'create' } from POST /products/1/stories" do
      params_from(:post, "/products/1/stories").should == {:controller => "stories", :action => "create", :product_id => '1'}
    end
  
    it "should generate params { :controller => 'stories', action => 'show', id => '1' } from GET /products/1/stories/1" do
      params_from(:get, "/products/1/stories/1").should == {:controller => "stories", :action => "show", :product_id => '1', :id => "1"}
    end
  
    it "should generate params { :controller => 'stories', action => 'edit', id => '1' } from GET /products/1/stories/1;edit" do
      params_from(:get, "/products/1/stories/1/edit").should == {:controller => "stories", :action => "edit", :product_id => '1', :id => "1"}
    end
  
    it "should generate params { :controller => 'stories', action => 'update', id => '1' } from PUT /products/1/stories/1" do
      params_from(:put, "/products/1/stories/1").should == {:controller => "stories", :action => "update", :product_id => '1', :id => "1"}
    end
  
    it "should generate params { :controller => 'stories', action => 'destroy', id => '1' } from DELETE /products/1/stories/1" do
      params_from(:delete, "/products/1/stories/1").should == {:controller => "stories", :action => "destroy", :product_id => '1', :id => "1"}
    end
  end
end
