Rails.application.routes.draw do
  namespace :v1 do
    # require 'sidekiq/web'
    # mount Sidekiq::Web => '/sidekiq'
    post "/mine_block", to: "coin_blockchains#mine_block"
    post "/add_user", to: "coin_blockchains#add_user"
    post "/add_node", to: "coin_blockchains#add_node"
    get "/blockchain", to: "blockchains#show"
    post "/renew_blockchain", to: "renew_blockchains#show"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
