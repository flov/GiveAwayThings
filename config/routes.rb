ActionController::Routing::Routes.draw do |map|


  map.resources :newsletters, :references
  map.resources :messages, :except => :new, :member => { :reply => :get, :newer => :get} 
  
  map.signup 'signup',   :controller => 'people',     :action => 'new'
  map.logout 'logout',   :controller => 'sessions',   :action => 'destroy'
  map.login 'login',     :controller => 'sessions',   :action => 'new'
  map.welcome 'welcome', :controller => 'people',     :action => 'welcome'
  map.search 'search',   :controller => 'items',      :action => 'index'
  map.inbox 'inbox',     :controller => 'messages',   :action => 'index'
  map.why 'why',         :controller => 'pages',      :action => 'why'

  map.oauth_request   '/oauth/:provider',          :controller => 'oauth', :action => 'start' 
  map.oauth_callback  '/oauth/:provider/callback', :controller => 'oauth', :action => 'callback'

  map.resources :items
  map.resources :people, :has_many => [:items],
                         :collection => {:link_user_accounts => :get},
                         :member => {
                            :confirm_email => :get,
                            :leave_reference => :get,
                            :create_reference => :post,
                            :settings => :get,
                            :unconfirmed_email => :get,
                            :requests => :get } do |people|
    people.new 'new_message', :controller => 'messages', :action => 'new'                               
  end
  
  map.resources :sessions
  map.resources :requests, :member => { :decline => :get, 
                                        :accept => :get, 
                                        :reset_accept => :post,
                                        :take_back => :delete,
                                        :taken => :get, 
                                        :given => :get,
                                        :create_reference => :post }
  map.resources :categories, :sections
  
  map.root                    :controller => "people", :action => "intro"
  map.connect ':id',          :controller => 'people', :action => 'show', :conditions => { :method => :get }
# map.connect ':id/:action',  :controller => 'people', :action => 'show', :conditions => { :method => :get }

end
