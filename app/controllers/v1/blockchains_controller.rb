module V1
  class BlockchainsController < ApplicationController
    def mine 
      # render json: { message: "bloco gerado!", block: blockchain.mine_block.last }
    end

    def show
      # render json: { blockchain: blockchain.blockchain }
    end

    def renew_blockchain
      # blockchain.update_blockchain(params["blocks"])
      # render json: { message: blockchain.log  blockchain: blockchain.blockchain }
    end

    def add_node
      # CoinBlockchain.create(params["blocks"])
      # render json: { message: blockchain.log  blockchain: blockchain.blockchain }
    end

    private

    def blockchain
      # @coin_blockchain ||= CoinBlockchain.new(params["name"])
    end
  end
end