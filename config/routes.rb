# frozen_string_literal: true
require 'resque/server'

Rails.application.routes.draw do

  devise_for :users#, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  mount RootApi => '/'
  mount Resque::Server.new, at: '/resque'
  resources :events do
    resources :items
  end

  root 'home#index'
  
  get 'emails', to: 'emails#index'

  post :toggle, to: 'locales#toggle'

  resources :users
  resources :roles
  resources :items

  resources :events do
    resources :items
  end
  resources :events
  get 'stats', to: 'stats#index'
  get 'about', to: 'about#index'
end
