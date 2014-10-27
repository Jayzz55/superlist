Superlist::Application.routes.draw do

  devise_for :users
    resources :users, only: [:update, :show]

  resources :categories, except: [:show] do
    resources :todos, only: [:create, :destroy]
  end

  get 'about' => 'welcome#about'

  root to: 'welcome#index'

end
