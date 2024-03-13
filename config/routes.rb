Rails.application.routes.draw do
  namespace :home do
    get 'welcome/index'
  end
  namespace :users_backoffice do
    get 'welcome/index'
  end
  namespace :admins_backoffice do
    get 'welcome/index'
  end
  devise_for :users
  devise_for :admins

  get 'inicio', to: 'home/welcome#index'
  root 'home/welcome#index'
end
