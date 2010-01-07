ActionController::Routing::Routes.draw do |map|
  
  map.signup 'signup', :controller => 'people', :action => 'new'
  map.logout 'logout', :controller => 'sessions', :action => 'destroy'
  map.login 'login', :controller => 'sessions', :action => 'new'
  map.welcome 'welcome', :controller => 'people', :action => 'index'
  map.resources :sessions
  map.resources :items
  map.resources :cities

  map.resources :people, :has_many => :items

  map.root :controller => "people"

end
