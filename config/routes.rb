PiensaQue::Application.routes.draw do
  
  resources :musics
  resources :pnsqs
  resources :request_invitations
  resources :relations
  resources :sessions
  resources :tags
  
  resources :users do
    member do
      get :relations_in_holder
      get :change_password_in_holder
      get :new_personal_pnsq_in_holder
      put :update_password
    end

    collection do
    end
  end

  get '/signout', :to => 'sessions#destroy', :as => 'signout'
  get '/sessions', :to => 'sessions#index', :as => 'login', :path => '/login'

  get '/:nick' => 'users#show', :as => 'user_nick'
  get '/users/:id/edit', :to => 'users#edit', :as => 'settings_user',:path => '/:nick/settings'

  get 'admin_panel', :to => 'application#admin_panel', :as => 'admin_panel', :path => '/a/panel'

  root :to => 'application#index'
end
