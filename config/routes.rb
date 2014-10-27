Superlist::Application.routes.draw do

  devise_for :users
    resources :users, only: [:update, :show]

  resources :categories, only: [:index, :create, :destroy] do
    resources :todos, only: [:create, :destroy]
  end

  get 'about' => 'welcome#about'

  root to: 'welcome#index'

end
