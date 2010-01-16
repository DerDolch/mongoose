ActionController::Routing::Routes.draw do |map|

  map.resources :teams

  map.logout '/logout', :controller => 'user_sessions', :action => 'destroy'
  map.login '/login', :controller => 'user_sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.resources :users

  map.resource :user_session

  map.resources :products do |p|
    p.resources :releases
    p.resources :sprints
    p.resources :stories, :collection => { :update_order => :put, :update_sprint_assoc => :put } do |s|
       s.resources :tasks, :collection => { :update_task_status => :put} 
    end
  end

  map.root :controller => "products"

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'

end
