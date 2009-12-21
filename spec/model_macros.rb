module ModelMacros
  
  def valid_product_attributes(options={})
    {
      :name => 'Test', 
      :description => 'Hello World', 
      :identifier => 'HIWLD', 
      :status => 'Active'
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
      :status => 'Open'
    }.merge(options)
  end
  
  def valid_task_attributes(options={})
    {
      :story_id => 1, 
      :title => "title", 
      :description =>"desc",
      :hours => 1, 
      :status => 'In Progress'
    }.merge(options)
  end

  def valid_user_attributes(options={})
    {
      :first_name => "John", 
      :last_name => "Doe", 
      :login => "johndoe", 
      :email => 'test@example.com',
      :status => 'Active',
      :password => '123456',
      :password_confirmation => '123456',
      :persistence_token => 'token goes here'
    }.merge(options)
  end
end

