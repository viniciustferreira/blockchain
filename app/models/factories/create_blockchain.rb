module Factories
  class CreateBlockchain

    def self.create_coin_block
      blockchain = CoinBlockchain.new.initialize_blockchain 
      blockchain.mine_block
    end
  end
end