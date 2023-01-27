Rails.application.routes.draw do
    scope '(:locale)', locale: /es|en/ do
        resources :newsletters
        resources :categories

        resources :contactos
        get '/contacto/new/interests', to: 'contactos#interests'
        get '/contacto', to: 'contactos#index'

        resources :articles
        get '/articles/:order_by/:asc_desc', to: 'articles#index'
        resources :projects
        get '/projects/:order_by/:asc_desc', to: 'projects#index'
        resources :products
        get '/products/:order_by/:asc_desc', to: 'products#index'

        resources :users do
            delete '/:edit_token', to: 'users#destroy', on: :member
            get '/edit/:edit_token', to: 'users#edit', on: :member
            get '/confirmation/:confirmation_token', to: 'users#confirmation', on: :collection
            get '/unsubscribe/:newsletter_token', to: 'users#unsubscribe', on: :collection
            post '/subscribe', to: 'users#subscribe', on: :collection
        end

        devise_for :admins, controllers: { registrations: 'admin_registrations' }
        scope 'dashboard' do
            get '/edit', to: 'dashboard#edit'
            get '/articles', to: 'dashboard#articles'
            get '/categories', to: 'dashboard#categories'
            get '/newsletters', to: 'dashboard#newsletters'
            get '/trash', to: 'dashboard#trash'
            get '/users', to: 'dashboard#users'
            get '/', to: 'dashboard#articles'
        end

        get '/nosotros', to: 'nosotros#nosotros'

        root 'main#main'
    end

    get '/:locale' => 'main#main', locale: /es|en/
end
