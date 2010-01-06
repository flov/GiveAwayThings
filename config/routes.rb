ActionController::Routing::Routes.draw do |map|
  map.signup 'signup', :controller => 'people', :action => 'new'
  map.logout 'logout', :controller => 'sessions', :action => 'destroy'
  map.login 'login', :controller => 'sessions', :action => 'new'
  map.resources :sessions

  map.resources :people

  
  map.signup 'signup', :controller => 'people', :action => 'new'
  map.logout 'logout', :controller => 'sessions', :action => 'destroy'
  map.login 'login', :controller => 'sessions', :action => 'new'
  map.welcome 'welcome', :controller => 'people', :action => 'index'
  map.resource :sessions
  map.resource :items
  
  map.resource :people, :has_many => :items

  map.root :controller => "homepages"

end
