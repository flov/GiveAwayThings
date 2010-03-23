ActionController::Routing::Routes.draw do |map|


  map.resources :newsletters
  map.resources :messages, :except => :new, :member => { :reply => :get, :newer => :get} 
  
  map.signup 'signup',   :controller => 'people',     :action => 'new'
  map.logout 'logout',   :controller => 'sessions',   :action => 'destroy'
  map.login 'login',     :controller => 'people',     :action => 'new'
  map.welcome 'welcome', :controller => 'people',     :action => 'welcome'
  map.search 'search',   :controller => 'items',      :action => 'index'
  map.inbox 'inbox',   :controller => 'messages',   :action => 'index'

  map.resources :items, :member => { :taken => :get }
  map.resources :people, :has_many => [:items], :member => {
                            :confirm_email => :get,
                            :settings => :get,
                            :unconfirmed_email => :get } do |people|
    people.new 'new_message', :controller => 'messages', :action => 'new'                               
  end
  map.resources :sessions
  map.resources :requests, :member => { :decline => :get, :accept => :get, :reset_accept => :post }
  map.resources :categories, :sections
  
  map.root               :controller => "people", :action => "welcome"


end
