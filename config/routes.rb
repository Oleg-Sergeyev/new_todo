# frozen_string_literal: true
require 'resque/server'

Rails.application.routes.draw do

  devise_for :users#, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  mount RootApi => '/'

  mount Resque::Server.new, at: '/resque'

  root 'home#index'
  get 'stats', to: 'stats#index'
  get 'about', to: 'about#index'
  get 'emails', to: 'emails#index'

  post :toggle, to: 'locales#toggle'
  post :journal, to: 'events#journal'
  post '/events/:event_id/items/new(.:format)' => 'items#create', as: :create_item

  resources :users
  resources :roles
  resources :items
  resources :events

  resources :events do
    resources :items
  end
end
