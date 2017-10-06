Rails.application.routes.draw do
  get 'profiles/show'

  devise_for :users, :controllers => { registrations: 'registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :posts do
  	resources :comments
  end
  
  root 'posts#index'
  # using GET rather than POST or PATCH because it lets us use a dynamic parameter for the sake of our route. just writing GET 'user_name', our route would be fixed, this setup allows us to pass user names as the params.
  # we will get the details for what to do with this route from the 'profiles' controller and the 'show' action.
  # as: :profile lets us use rails routing helpers. We can use the profile_path helper
  get ':user_name', to: 'profiles#show', as: :profile
end
