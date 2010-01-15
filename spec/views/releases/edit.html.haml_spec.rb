require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/releases/edit.html.haml" do
  include ReleasesHelper

  before(:each) do
    assigns[:release] = @release = stub_model(Release,
      :new_record? => false,
      :name => "value for name"
    )
    assigns[:product] = @product = mock_model(Product)
  end

  it "renders the edit release form" do
    render

    response.should have_tag("form[action=#{product_release_path(@product,@release)}][method=post]") do
      with_tag('input#release_name[name=?]', "release[name]")
    end
  end
end
