Rails.application.routes.draw do
  namespace :v1 do
    get "/mine", to: "blockchains#mine"
    get "/blockchain", to: "blockchains#show"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
