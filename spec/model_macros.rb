module ModelMacros
  
  def valid_product_attributes(options={})
    {
      :name => 'Test', 
      :description => 'Hello World', 
      :identifier => 'HIWLD', 
      :product_status_id => 1, 
      :product_status => mock_model(ProductStatus, :id => 1, :title => 'Active')
    }.merge(options)
  end
  
  def valid_story_attributes(options={})
    {
      :title => 'My Story',
      :effort => 2,
      :description => 'As a user I want...',
      :sprint_id => 1
    }.merge(options)
  end
  
  def valid_sprint_attributes(options={})
    {
      :title => 'The Best Sprint',
      :goal => 'To finish this product',
      :start_date => 3.days.ago,
      :end_date => 12.days.from_now,
      :product_id => 1,
      :sprint_status_id => 1,
      :sprint_status => mock_model(SprintStatus, :id => 1, :title => 'Active')
    }
  end

end

