Superlist::Application.routes.draw do

  devise_for :users
  
  resources :users, only: [:update, :show] do
    resources :todos, only: [:create, :destroy]
  end

  resources :todos, only: [] do
    collection do
        delete 'destroy_multiple'
      end
  end

  get 'about' => 'welcome#about'

  root to: 'welcome#index'

end
