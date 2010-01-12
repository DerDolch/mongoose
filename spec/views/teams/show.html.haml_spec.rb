require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/teams/show.html.haml" do
  include TeamsHelper
  before(:each) do
    assigns[:team] = @team = stub_model(Team,
      :name => "value for name",
      :active => false
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ name/)
    response.should have_text(/false/)
  end
end
