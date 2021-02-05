Rails.application.routes.draw do
  resources :newsletters
  resources :articles
  resources :proyectos

  devise_for :admins, :controllers => { registrations: 'admin_registrations' }

  devise_for :users, :controllers => { registrations: 'registrations' }
  get '/users', to: 'users#index'

  resources :contactos
  get '/contacto', to: 'contactos#index'
  get '/contacto/new', to: 'contactos#new'
  
  get '/nosotros', to: 'nosotros#nosotros'

  root 'main#main'
end