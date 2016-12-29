Rails.application.routes.draw do

  root 'signatures#home'
  get 'signatures/home'

  resources :signatures, :sig2, :sig3, :sig4, :requesting, :template, only: [:new, :create] do
    collection do
      post 'callbacks'
    end
	end
end