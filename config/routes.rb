Rails.application.routes.draw do
  # STEP 1: A ROUTE triggers a controller action
  # verb "/urls" => "namespace/controllers#action"
  namespace :api do
    #records
    get "/records" => "records#index"
    post "/records" => "records#create"
    get "/records/:id" => "records#show"
    patch "/records/:id" => "records#update"
    delete "/records/:id" => "records#destroy"
    #vehicles
    get "/vehicles/search" => "vehicles#search"
    get "/vehicles" => "vehicles#index"
    post "/vehicles" => "vehicles#create"
    delete "/vehicles/:id" => "vehicles#destroy"
    #shops
    get "/shops" => "shops#index"
    post "/shops" => "shops#create"
    get "/shops/:id" => "shops#show"
    patch "/shops/:id" => "shops#update"
    delete "/shops/:id" => "shops#destroy"
    #users/user-related
    get "/users" => "users#index"
    post "/users" => "users#create"
    post "/sessions" => "sessions#create"
  end
end
