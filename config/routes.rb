Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"

    get "/signup", to: "users#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    get "/confirm_email", to: "users#confirm_email"
    post "/confirm_email", to: "users#check_code"

    resources :users, only: [:new, :create, :show]
    resources :notifications, only: [:new, :create, :destroy]

    namespace :admin do
      get "/users", to: "users#index"
      get "/courses", to: "courses#index"
      put "/activation", to: "users#update"
      delete "/delete", to: "users#destroy"
      put "/start_course", to: "courses#start"
      put "/finish_course", to: "courses#finish"
      delete "/delete_course", to: "courses#destroy"

      resources :users
      resources :notifications, except: :new
    end
    mount ActionCable.server => "/cable"
  end
  resources :users, only: [:new, :create, :show, :edit, :update]
  resources :courses, only: [:index, :show] do
    resources :subjects, only: [:show]
  end
  resources :user_course_tasks, only: [:new, :create]

  post "/login", to: "sessions#create"
  get "/notfound", to: "courses#notfound"
  delete "/logout", to: "sessions#destroy"
end
