# frozen_string_literal: true
require 'resque/server'

Rails.application.routes.draw do
  mount RootApi => '/'
  mount Resque::Server.new, at: '/resque'
  resources :events do
    resources :items
  end

  root 'home#index'
  
  get 'emails', to: 'emails#index'

  post :toggle, to: 'locales#toggle'

  # scope '/:locale' do
  #   get 'home', to: 'home#index'
  # end

  # devise_for :users
  devise_for :users # , :path_prefix => 'admin'
  match 'users/:id' => 'admin/users#destroy', via: :delete, as: :admin_destroy_user
  match 'users/:id' => 'admin/users#create', via: :create, as: :admin_create_user
  # match 'users/:id' => 'admin/users#edit', via: :edit, as: :admin_edit_user
  # put 'admin/users/:id/edit', to: 'admin/users#edit', via: :edit, as: :admin_edit_user

  resources :users

  match 'roles/:id' => 'admin/roles#destroy', via: :delete, as: :admin_destroy_role
  match 'roles/:id' => 'admin/roles#create', via: :create, as: :admin_create_role
  resources :roles

  resources :items

  # devise_for :user, path_names: {
  #   sign_in: 'login', sign_out: 'logout'
  # }
  resources :events do
    resources :items
  end
  resources :events
  # get 'events/page/(:page(.:format))', to: 'events#index'
  # get 'events/page', to: 'events#index'
  get 'stats', to: 'stats#index'
  get 'about', to: 'about#index'
  get 'admin/images', to: 'admin/images#index'
  post 'admin/images/create', to: 'admin/images#create'
  # get 'calendar', to: 'calendar#index', as: 'calendar_index'
  # get 'about', to: 'abount#index', as: 'about_index'
end
