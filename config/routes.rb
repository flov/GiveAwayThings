ActionController::Routing::Routes.draw do |map|
  map.signup 'signup', :controller => 'people', :action => 'new'
  map.logout 'logout', :controller => 'sessions', :action => 'destroy'
  map.login 'login', :controller => 'sessions', :action => 'new'
  map.resources :sessions

  map.resources :people

  
  map.signup 'signup',   :controller => 'people',     :action => 'new'
  map.logout 'logout',   :controller => 'sessions',   :action => 'destroy'
  map.login 'login',     :controller => 'sessions',   :action => 'new'
  map.welcome 'welcome', :controller => 'items',      :action => 'index'
  map.city 'city',       :controller => 'searches',   :action => 'city'
  map.item 'item',       :controller => 'searches',   :action => 'item'
  map.resources :sessions
  map.resources :items
  map.resources :people, :has_many => :items

  map.root :controller => "people"

end
