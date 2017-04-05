Rails.application.routes.draw do

  get '/', to: 'home#index', as: 'root'

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :assignments, only: [:create]
      get '/adjectives', to: 'adjectives#index'
      resources :cohorts, only: [:index] do
        get '/users', to: 'cohorts/users#index'
      end
      namespace :users do 
        get '/:id/assignments', to: 'assignments#index'
        post '/:id/descriptions', to: 'descriptions#create'
        get '/:id/descriptions', to: 'descriptions#index'
        get '/:id', to: 'users#show'
      end
    end
  end
end
