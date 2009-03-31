require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TasksController do
  describe "route generation" do

    it "should map { :controller => 'tasks', :action => 'index' } to /products/1/stories/1/tasks" do
      route_for(:controller => "tasks", :action => "index", :product_id => '1', :story_id => '1').should == "/products/1/stories/1/tasks"
    end
  
    it "should map { :controller => 'tasks', :action => 'new' } to /products/1/stories/1/tasks/new" do
      route_for(:controller => "tasks", :action => "new", :product_id => '1', :story_id => '1').should == "/products/1/stories/1/tasks/new"
    end
  
    it "should map { :controller => 'tasks', :action => 'show', :id => '1' } to /products/1/stories/1/tasks/1" do
      route_for(:controller => "tasks", :action => "show", :id => '1', :product_id => '1', :story_id => '1').should == "/products/1/stories/1/tasks/1"
    end
  
    it "should map { :controller => 'tasks', :action => 'edit', :id => '1' } to /products/1/stories/1/tasks/1/edit" do
      route_for(:controller => "tasks", :action => "edit", :id => '1', :product_id => '1', :story_id => '1').should == "/products/1/stories/1/tasks/1/edit"
    end
  
    it "should map { :controller => 'tasks', :action => 'update', :id => '1'} to /tasks/1" do
      route_for(:controller => "tasks", :action => "update", :id => '1', :product_id => '1', :story_id => '1').should == {:path => "/products/1/stories/1/tasks/1", :method => :put}
    end
  
    it "should map { :controller => 'tasks', :action => 'destroy', :id => '1'} to /products/1/stories/1/tasks/1" do
      route_for(:controller => "tasks", :action => "destroy", :id => '1', :product_id => '1', :story_id => '1').should == {:path => "/products/1/stories/1/tasks/1", :method => :delete}
    end
  end

  describe "route recognition" do

    it "should generate params { :controller => 'tasks', action => 'index' } from GET /products/1/stories/1/tasks" do
      params_from(:get, "/products/1/stories/1/tasks").should == {:controller => "tasks", :action => "index", :product_id => '1', :story_id => '1'}
    end
  
    it "should generate params { :controller => 'tasks', action => 'new' } from GET /products/1/stories/1/tasks/new" do
      params_from(:get, "/products/1/stories/1/tasks/new").should == {:controller => "tasks", :action => "new", :product_id => '1', :story_id => '1'}
    end
  
    it "should generate params { :controller => 'tasks', action => 'create' } from POST /products/1/stories/1/tasks" do
      params_from(:post, "/products/1/stories/1/tasks").should == {:controller => "tasks", :action => "create", :product_id => '1', :story_id => '1'}
    end
  
    it "should generate params { :controller => 'tasks', action => 'show', id => '1' } from GET /products/1/stories/1/tasks/1" do
      params_from(:get, "/products/1/stories/1/tasks/1").should == {:controller => "tasks", :action => "show", :id => "1", :product_id => '1', :story_id => '1'}
    end
  
    it "should generate params { :controller => 'tasks', action => 'edit', id => '1' } from GET /products/1/stories/1/tasks/1;edit" do
      params_from(:get, "/products/1/stories/1/tasks/1/edit").should == {:controller => "tasks", :action => "edit", :id => "1", :product_id => '1', :story_id => '1'}
    end
  
    it "should generate params { :controller => 'tasks', action => 'update', id => '1' } from PUT /products/1/stories/1/tasks/1" do
      params_from(:put, "/products/1/stories/1/tasks/1").should == {:controller => "tasks", :action => "update", :id => "1", :product_id => '1', :story_id => '1'}
    end
  
    it "should generate params { :controller => 'tasks', action => 'destroy', id => '1' } from DELETE /products/1/stories/1/tasks/1" do
      params_from(:delete, "/products/1/stories/1/tasks/1").should == {:controller => "tasks", :action => "destroy", :id => "1", :product_id => '1', :story_id => '1'}
    end
  end
end
