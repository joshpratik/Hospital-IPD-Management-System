Rails.application.routes.draw do
  devise_for :users, path: "", path_names: {
                       sign_in: "login",
                       sign_out: "logout",
                       registration: "signup",
                     },
                     controllers: {
                       sessions: "users/sessions",
                       registrations: "users/registrations",
                     }
  resources :user_details, :admissions, :addresses, :medicines, :rooms
  resources :users
  post 'treatments/add', to: 'theatments#add'
end
