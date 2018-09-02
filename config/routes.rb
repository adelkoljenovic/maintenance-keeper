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

    get "/vehicles" => "vehicles#index" #done; tested
    post "/vehicles" => "vehicles#create" #done; tested
    delete "/vehicles/:id" => "vehicles#destroy" #will not do due to time
    get "/vehicles/search" => "vehicles#search" #done; tested
    #shops
    get "/shops" => "shops#index"
    post "/shops" => "shops#create" #done; tested
    get "/shops/:id" => "shops#show"
    patch "/shops/:id" => "shops#update"
    delete "/shops/:id" => "shops#destroy"
    #users/user-related
    get "/users" => "users#index"
    post "/users" => "users#create"
    post "/sessions" => "sessions#create"
  end
end
