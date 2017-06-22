Rails.application.routes.draw do

  root 'signatures#home'
  get 'signatures/home'

  post '/' => 'signatures#callbacks'
  # post '/' => 'signatures#create'
  # post '/' => 'signatures#get_first_signature_id'

  resources :signatures, :sig2, :sig3, :sig4, :requesting, :template, :reminder, :whitelabel, only: [:new, :create] do
    collection do
      post 'callbacks'
    end
	end
end