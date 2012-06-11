ActionController::Routing::Routes.draw do |map|


  
  map.resources :namespaces
  map.resources :revisions
  map.resources :users
  map.connect 'wiki/:data', :controller => "files", :action => "handle", :requirements => { :data => /File:.+/ }
  map.connect 'wiki/:data', :controller => "special", :action => "handle", :requirements => { :data => /Special:.+/ }

  map.resources :wiki, :controller => "pages", :member => { :history => :get }
  map.connect 'wiki/destroy/:id', :controller => "pages", :action => "destroy"
  map.connect 'wiki/new', :controller => "pages", :action => "new"

  #map.connect '', :controller => "pages", :action => "index"
  map.connect '', :controller => "login", :action => "new"
  map.connect '/logout', :controller => "login", :action => "logout"
  map.resources :pages
  map.resources :login

end
