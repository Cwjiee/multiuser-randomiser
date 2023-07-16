Rails.application.routes.draw do
  resources :messages, only: %i[index]
  resources :users, only: %i[index create] do
    post 'add_message'
    post 'change_status'
  end
  mount ActionCable.server => '/cable'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
