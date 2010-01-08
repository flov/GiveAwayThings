ActionController::Routing::Routes.draw do |map|

  map.signup 'signup',   :controller => 'people',     :action => 'new'
  map.logout 'logout',   :controller => 'sessions',   :action => 'destroy'
  map.login 'login',     :controller => 'sessions',   :action => 'new'
  map.welcome 'welcome', :controller => 'people',     :action => 'welcome'
  map.resources :items
  map.resources :people, :has_many => :items
  map.resources :sessions
  map.cities 'cities',     :controller => 'items',     :action => 'search_city'
  map.items 'items',      :controller => 'items',     :action => 'search_item'

  map.root               :controller => "people", :action => "welcome"

end
