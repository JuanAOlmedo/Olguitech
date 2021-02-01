Rails.application.routes.draw do
  resources :newsletters
  resources :mains
  resources :proyectos
  devise_for :admins, :controllers => { registrations: 'admin_registrations' }
  resources :contactos
  resources :nosotros
  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :articles
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'mains#index'

  match 'users' => 'users#index', via: :get
end