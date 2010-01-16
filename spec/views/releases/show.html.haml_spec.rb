require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/releases/show.html.haml" do
  include ReleasesHelper
  before(:each) do
    assigns[:release] = @release = stub_model(Release,
      :name => "value for name"
    )
    assigns[:product] = @product = mock_model(Product)
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ name/)
  end
end
