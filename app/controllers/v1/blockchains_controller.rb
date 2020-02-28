module V1
  class BlockchainsController < ApplicationController
    def mine 
      render json: { message: "bloco gerado!", block: blockchain.mine_block.last }
    end

    def show
      render json: { blockchain: blockchain.blockchain }
    end

    private

    def blockchain
      @generic_blockchain ||= GenericBlockchain.new
    end
  end
end