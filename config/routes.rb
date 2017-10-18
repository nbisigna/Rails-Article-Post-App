Rails.application.routes.draw do
	
  devise_for :users, controllers: {
        sessions: 'users/sessions'
      }
get 'users/top', to: 'users#top', as: 'top_users'
	get 'posts/top', to: 'posts#top', as: 'top'
get 'posts/loved', to: 'posts#loved', as: 'loved'
get 'posts/hated', to: 'posts#hated', as: 'hated'
get 'user/:id', to: 'users#show', as: 'user_profile'
	
  resources :posts do
    resources :comments
	member do
		get 'like'
		get 'dislike'
	end
  end
    
	resources :users do
    member do
      get :following, :followers
    end
  end

resources :relationships,       only: [:create, :destroy]
  

	
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'posts#index'
end
