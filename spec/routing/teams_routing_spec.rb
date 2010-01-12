require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TeamsController do
  describe "route generation" do
    it "maps #index" do
      route_for(:controller => "teams", :action => "index").should == "/teams"
    end

    it "maps #new" do
      route_for(:controller => "teams", :action => "new").should == "/teams/new"
    end

    it "maps #show" do
      route_for(:controller => "teams", :action => "show", :id => "1").should == "/teams/1"
    end

    it "maps #edit" do
      route_for(:controller => "teams", :action => "edit", :id => "1").should == "/teams/1/edit"
    end

    it "maps #create" do
      route_for(:controller => "teams", :action => "create").should == {:path => "/teams", :method => :post}
    end

    it "maps #update" do
      route_for(:controller => "teams", :action => "update", :id => "1").should == {:path =>"/teams/1", :method => :put}
    end

    it "maps #destroy" do
      route_for(:controller => "teams", :action => "destroy", :id => "1").should == {:path =>"/teams/1", :method => :delete}
    end
  end

  describe "route recognition" do
    it "generates params for #index" do
      params_from(:get, "/teams").should == {:controller => "teams", :action => "index"}
    end

    it "generates params for #new" do
      params_from(:get, "/teams/new").should == {:controller => "teams", :action => "new"}
    end

    it "generates params for #create" do
      params_from(:post, "/teams").should == {:controller => "teams", :action => "create"}
    end

    it "generates params for #show" do
      params_from(:get, "/teams/1").should == {:controller => "teams", :action => "show", :id => "1"}
    end

    it "generates params for #edit" do
      params_from(:get, "/teams/1/edit").should == {:controller => "teams", :action => "edit", :id => "1"}
    end

    it "generates params for #update" do
      params_from(:put, "/teams/1").should == {:controller => "teams", :action => "update", :id => "1"}
    end

    it "generates params for #destroy" do
      params_from(:delete, "/teams/1").should == {:controller => "teams", :action => "destroy", :id => "1"}
    end
  end
end
