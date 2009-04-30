ActionController::Routing::Routes.draw do |map|
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.resources :users

  map.resource :session

  
  map.resources :products do |p|
    p.resources :sprints
    p.resources :stories, :collection => { :update_order => :put, :update_sprint_assoc => :put } do |s|
       s.resources :tasks, :collection => { :update_task_status => :put} 
    end
  end

  map.root :controller => "products"

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'

end
