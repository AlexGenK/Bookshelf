Rails.application.routes.draw do

  get 'home'=>'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :books
  resources :authors

  resources :categories do
    resources :books
  end

  root to: 'home#index'

end
