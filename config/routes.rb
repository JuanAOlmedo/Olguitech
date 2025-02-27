Rails.application.routes.draw do
    scope '(:locale)', locale: /es|en/ do
        resources :newsletters do
            patch 'status', action: 'change_status', on: :member
        end
        resources :categories do
            patch 'unrelate', on: :member
        end
        resources :super_categories

        resources :messages

        resources :solutions do
            patch 'status', action: 'change_status', on: :member
        end
        resources :projects do
            patch 'status', action: 'change_status', on: :member
        end
        resources :products do
            patch 'status', action: 'change_status', on: :member
        end

        resources :users do
            delete '/:edit_token', to: 'users#destroy', on: :member
            get '/edit/:edit_token', to: 'users#edit', on: :member
            get '/confirmation/:confirmation_token', to: 'users#confirmation', on: :collection
            get '/unsubscribe/:newsletter_token', to: 'users#unsubscribe', on: :collection
            post '/subscribe', to: 'users#subscribe', on: :collection
        end

        devise_for :admins, controllers: { registrations: 'admins/registrations', sessions: 'admins/sessions' }
        scope 'dashboard' do
            get '/edit', to: 'dashboard#edit'
            get '/articles', to: 'dashboard#articles'
            get '/categories', to: 'dashboard#categories'
            get '/newsletters', to: 'dashboard#newsletters'
            get '/trash', to: 'dashboard#trash'
            get '/users', to: 'dashboard#users'
            get '/', to: 'dashboard#articles'
        end

        get '/contacto', to: 'main#contacto'
        get '/nosotros', to: 'main#nosotros'
        root 'main#main'
    end

    get '/:locale' => 'main#main', locale: /es|en/
end
