Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "calendars#index"
  resources :calendars

  resources :users , only: [:index, :new, :create, :show,:update]

  get 'sessions/new'
  post 'sessions/new' , to: 'sessions#create'
  delete 'sessions/new', to: 'sessions#destroy'
end
