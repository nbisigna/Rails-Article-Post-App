Rails.application.routes.draw do

  devise_for :users, controllers: {
        sessions: 'users/sessions'
      }
get 'users/feed', to: 'users#feed', as: 'feed'
get 'posts/opinions', to: 'comments#opinions', as: 'opinions'
get 'posts/portfolio', to: 'posts#portfolio', as: 'portfolio'
get 'users/top', to: 'users#top', as: 'top_users'
get 'posts/top', to: 'posts#top', as: 'top'
get 'posts/topday', to: 'posts#topday', as: 'top_day'
get 'posts/topweek', to: 'posts#topweek', as: 'top_week'
get 'posts/topmonth', to: 'posts#topmonth', as: 'top_month'
get 'posts/topyear', to: 'posts#topyear', as: 'top_year'
get 'posts/loved', to: 'posts#loved', as: 'loved'
get 'posts/lovedday', to: 'posts#lovedday', as: 'loved_day'
get 'posts/lovedweek', to: 'posts#lovedweek', as: 'loved_week'
get 'posts/lovedmonth', to: 'posts#lovedmonth', as: 'loved_month'
get 'posts/lovedyear', to: 'posts#lovedyear', as: 'loved_year'
get 'posts/hated', to: 'posts#hated', as: 'hated'
get 'posts/hatedday', to: 'posts#hatedday', as: 'hated_day'
get 'posts/hatedweek', to: 'posts#hatedweek', as: 'hated_week'
get 'posts/hatedmonth', to: 'posts#hatedmonth', as: 'hated_month'
get 'posts/hatedyear', to: 'posts#hatedyear', as: 'hated_year'
get 'user/:id', to: 'users#show', as: 'user_profile'
	
  resources :posts do
    resources :comments
	member do
		get 'like'
		get 'dislike'
	end
  end
	resources :comments do
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
