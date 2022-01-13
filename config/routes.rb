Rails.application.routes.draw do
    scope "(:locale)", locale: /es|en/ do
        resources :newsletters
        resources :categories

        resources :contactos
        get '/contacto', to: 'contactos#index'
        get '/contacto/new', to: 'contactos#new'

        resources :articles
        get '/articles/:order_by/:asc_desc', to: 'articles#index'
        resources :proyectos
        get '/proyectos/:order_by/:asc_desc', to: 'proyectos#index'
        resources :products
        get '/products/:order_by/:asc_desc', to: 'products#index'

        resources :users do
            delete "/:edit_token", to: 'users#destroy', on: :member
            get "/edit/:edit_token", to: 'users#edit', on: :member
            get "/confirmation/:confirmation_token", to: 'users#confirmation', on: :collection
            get '/unsubscribe/:newsletter_token', to: 'users#unsubscribe', on: :collection
            post "/subscribe", to: "main#subscribe", on: :collection
        end

        devise_for :admins, :controllers => { registrations: 'admin_registrations' }

        get '/nosotros', to: 'nosotros#nosotros'

        root 'main#main'
    end

    get '/:locale' => 'main#main', locale: /es|en/
end