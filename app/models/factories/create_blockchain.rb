module Factories
  class CreateBlockchain

    def self.create_coin_block
      blockchain = CoinBlockchain.new.initialize_blockchain 
      procedure = blockchain.mine_block
      threads = []
      first_nonce = 1

      threads << Thread.new { procedure.call(first_nonce) }

      while true
        if threads.select { |thread| thread.status == false }.empty?
          final_thread = threads.map(&:value).first 
          threads.each(&:kill)
          return final_thread
        end
        threads << Thread.new { procedure.call(first_nonce *= 100) }
      end
    end
  end
end