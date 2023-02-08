Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :users, path: "", path_names: {
                       sign_in: "login",
                       sign_out: "logout",
                       registration: "signup",
                     },
                     controllers: {
                       sessions: "users/sessions",
                       registrations: "users/registrations",
                     }
  devise_scope :user do
    post '/users', to: 'users/registrations#create'
    post '/users/sign_in', to: 'users/sessions#create'
    delete '/users/sign_out', to: 'users/sessions#destroy'
  end
  resources :user_details, :admissions, :addresses, :medicines, :rooms, :users
  resources :treatments, only: [:create]
  get '/admissions/invoice/:id', to: 'admissions#invoice'
end
