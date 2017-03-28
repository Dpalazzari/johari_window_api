Rails.application.routes.draw do
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      get '/adjectives', to: 'adjectives#index'
    end
  end
end
