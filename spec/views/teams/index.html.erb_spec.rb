require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/teams/index.html.erb" do
  include TeamsHelper

  before(:each) do
    assigns[:teams] = [
      stub_model(Team,
        :name => "value for name",
        :active => false
      ),
      stub_model(Team,
        :name => "value for name",
        :active => false
      )
    ]
  end

  it "renders a list of teams" do
    render
    response.should have_tag("tr>td", "value for name".to_s, 2)
    response.should have_tag("tr>td", false.to_s, 2)
  end
end
