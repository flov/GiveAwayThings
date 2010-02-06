ActionController::Routing::Routes.draw do |map|
  map.resources :messages
  map.resources :newsletters

  map.signup 'signup',   :controller => 'people',     :action => 'new'
  map.logout 'logout',   :controller => 'sessions',   :action => 'destroy'
  map.login 'login',     :controller => 'sessions',   :action => 'new'
  map.welcome 'welcome', :controller => 'people',     :action => 'welcome'
  map.search 'search',   :controller => 'items',      :action => 'index'

  map.resources :items
  map.resources :people, :has_many => :items
  map.resources :sessions
  map.resources :requests
  map.resources :categories
  
  map.root               :controller => "people", :action => "welcome"

end
