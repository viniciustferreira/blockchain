module V1
  class CoinBlockchainsController < ApplicationController

    def mine_block
      new_block = Factories::CreateBlockchain.create_coin_block

      if new_block.nil?
        render json: { creation: "error" }, status: 401
      else
        render json: { creation: "ok", block_id: new_block.id }, status: 201
      end
    end

    def add_transactions
      # transactions = params[:transactions]
      # transactions.each |transaction| do
      #   new_transaction = Transaction.create(transaction)
      #   return false if !new_transaction.errors.empty?
      # end
      # true
    end

    def add_user
      user = User.create( name: params["name"])
      if  user.nil?
        render json: { creation: "error" } 
      else
        render json: { creation: "ok", user_id: user.id }
      end
    end

    def add_node
      node = Node.create(port: params["port"], url: params["url"])
      render json: { creation: "error" } and return if node.nil?

      { creation: "ok", node_id: node.id }
    end
  end 
end