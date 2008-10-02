namespace :db do
  namespace :bootstrap do
    desc  "create a user"
    task :user => :environment do
      user_status = UserStatus.find_or_create_by_name(:name => "Developer")
      u = User.find_by_login("testtest") || User.create!({:password => "testtest",:password_confirmation => "testtest",:user_status_id =>user_status.id, :first_name=>"test", :login=>"1testtest", :last_name=>"test",:email=>"1test@test.com"})
    end
    
    desc  "create a product"
    task :product => :environment do
      product_status = ProductStatus.find_by_title("teststatus") || ProductStatus.create!(:id => 1, :title => "teststatus")
      product = Product.find_by_name("testtest") || Product.create!(:name => "testtest", :description => "test", :identifier => "test", :product_status_id => product_status.id)
      user = User.find_by_login("testtest") || User.create!({:password => "testtest",:password_confirmation => "testtest",:user_status_id =>user_status.id, :first_name=>"test", :login=>"1testtest", :last_name=>"test",:email=>"1test@test.com"})
      product_user = ProductUser.first(:conditions => {:user_id => user.id, :product_id => product.id}) || ProductUser.create!(:user => user, :product => product)
    end
  end
end