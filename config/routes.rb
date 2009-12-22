ActionController::Routing::Routes.draw do |map|
  map.signup 'signup', :controller => 'people', :action => 'new'
  map.logout 'logout', :controller => 'sessions', :action => 'destroy'
  map.login 'login', :controller => 'sessions', :action => 'new'
  map.resources :sessions

  map.resources :people

  map.root :controller => "homepages"

end
