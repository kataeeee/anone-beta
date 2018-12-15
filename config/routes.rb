Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  get "/inquiries/new" => "inquiries#new"
  post "/inquiries/create" => "inquiries#create"

end
