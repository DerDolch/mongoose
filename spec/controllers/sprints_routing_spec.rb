require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SprintsController do
  describe "route generation" do

    it "should map { :controller => 'sprints', :action => 'index' } to /products/1/sprints" do
      route_for(:controller => "sprints", :action => "index", :product_id => '1').should == "/products/1/sprints"
    end
  
    it "should map { :controller => 'sprints', :action => 'new' } to /products/1/sprints/new" do
      route_for(:controller => "sprints", :action => "new", :product_id => '1').should == "/products/1/sprints/new"
    end
  
    it "should map { :controller => 'sprints', :action => 'show', :id => 1 } to /products/1/sprints/1" do
      route_for(:controller => "sprints", :action => "show", :id => 1, :product_id => '1').should == "/products/1/sprints/1"
    end
  
    it "should map { :controller => 'sprints', :action => 'edit', :id => 1 } to /products/1/sprints/1/edit" do
      route_for(:controller => "sprints", :action => "edit", :id => 1, :product_id => '1').should == "/products/1/sprints/1/edit"
    end
  
    it "should map { :controller => 'sprints', :action => 'update', :id => 1} to /products/1/sprints/1" do
      route_for(:controller => "sprints", :action => "update", :id => 1, :product_id => '1').should == "/products/1/sprints/1"
    end
  
    it "should map { :controller => 'sprints', :action => 'destroy', :id => 1} to /products/1/sprints/1" do
      route_for(:controller => "sprints", :action => "destroy", :id => 1, :product_id => '1').should == "/products/1/sprints/1"
    end
  end

  describe "route recognition" do

    it "should generate params { :controller => 'sprints', action => 'index' } from GET /products/1/sprints" do
      params_from(:get, "/products/1/sprints").should == {:controller => "sprints", :action => "index", :product_id => '1'}
    end
  
    it "should generate params { :controller => 'sprints', action => 'new' } from GET /products/1/sprints/new" do
      params_from(:get, "/products/1/sprints/new").should == {:controller => "sprints", :action => "new", :product_id => '1'}
    end
  
    it "should generate params { :controller => 'sprints', action => 'create' } from POST /products/1/sprints" do
      params_from(:post, "/products/1/sprints").should == {:controller => "sprints", :action => "create", :product_id => '1'}
    end
  
    it "should generate params { :controller => 'sprints', action => 'show', id => '1' } from GET /products/1/sprints/1" do
      params_from(:get, "/products/1/sprints/1").should == {:controller => "sprints", :action => "show", :id => "1", :product_id => '1'}
    end
  
    it "should generate params { :controller => 'sprints', action => 'edit', id => '1' } from GET /products/1/sprints/1;edit" do
      params_from(:get, "/products/1/sprints/1/edit").should == {:controller => "sprints", :action => "edit", :id => "1", :product_id => '1'}
    end
  
    it "should generate params { :controller => 'sprints', action => 'update', id => '1' } from PUT /products/1/sprints/1" do
      params_from(:put, "/products/1/sprints/1").should == {:controller => "sprints", :action => "update", :id => "1", :product_id => '1'}
    end
  
    it "should generate params { :controller => 'sprints', action => 'destroy', id => '1' } from DELETE /products/1/sprints/1" do
      params_from(:delete, "/products/1/sprints/1").should == {:controller => "sprints", :action => "destroy", :id => "1", :product_id => '1'}
    end
  end
end
