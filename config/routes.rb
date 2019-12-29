Rails.application.routes.draw do
  resources :resorts, :states, :snow_data
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'states#index'
  resources :states do
    resources :resorts
  end
  resources :resorts do
    resources :snow_data
  end

  get '/resorts/:id', to: 'resorts#show', as: 'resortget'
  get '/states/:id', to: 'states#show', as: 'stateget'

end
