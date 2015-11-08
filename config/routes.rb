Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :uploads
  resources :uploaded_files, only: [:create, :destroy]
  resources :feeds, only: :show, :defaults => { :format => :xml }

  post 'guest', to: 'welcome#guest'

  require 'sidekiq/web'
  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    username == ENV['SIDEKIQ_USERNAME'] && password == ENV['SIDEKIQ_PASSWORD']
  end if Rails.env.production?
  mount Sidekiq::Web, at: "/sidekiq"

  root 'welcome#index'
end
