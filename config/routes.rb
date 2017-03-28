Rails.application.routes.draw do
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      get '/adjectives', to: 'adjectives#index'
      namespace :users do 
        get '/:id/assignments', to: 'assignments#index'
      end
    end
  end
end
