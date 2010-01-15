require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/releases/new.html.haml" do
  include ReleasesHelper

  before(:each) do
    assigns[:release] = stub_model(Release,
      :new_record? => true,
      :name => "value for name"
    )
    assigns[:product] = @product = mock_model(Product)
  end

  it "renders new release form" do
    render

    response.should have_tag("form[action=?][method=post]", product_releases_path(@product)) do
      with_tag("input#release_name[name=?]", "release[name]")
    end
  end
end
