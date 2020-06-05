class CoinBlockchain < GenericBlockchain
  attr_accessor :transactions
  before_create :initialize_blockchain

  def initialize_blockchain
    super
    transaction_list
    self
  end

  def update_blockchain
    #atualizar o repositório
  end

  def mine_block
    return nil if transaction_list == ""

    create_first_block if CoinBlockchain.first.nil?

    creation_datetime = DateTime.now
    previous_hash = CoinBlockchain.last.block_hash
    good_nonce = false
    created_blockchain = nil
    threads = []
 
    procedure = Proc.new do |nonce|
      until good_nonce == true || created_blockchain do 
        hash = Digest::SHA2.hexdigest("#{nonce}#{previous_hash}#{transactions}")
        if is_hash_valid?(hash)
          good_nonce = true
          puts nonce
          Transaction.mark_transactions_as_clear(transaction_list)
          created_blockchain = CoinBlockchain.create({ nonce: nonce, previous_hash: previous_hash, block_type: "coin", block_hash: hash, transactions: transactions })
        else
          nonce = nonce + 1
        end
      end
    end

    threads << Thread.new { procedure.call(1) }
    threads << Thread.new { procedure.call(1000000) }

    while true
      if created_blockchain
        threads.each {|t| t.kill }
        return created_blockchain
      end
    end
  end

  private

  def transaction_list
    @transactions ||= Transaction.twenty_most_valuable
      .map(&:id)
      .join(',') 
  end
  
  #TODO: create a migration to do that
  def create_first_block
    first_datetime = DateTime.now
    Transaction.create_first_transaction
    CoinBlockchain.create(block_type: "coin", nonce: 1, previous_hash: "0", block_hash: Digest::SHA2.hexdigest("1#{first_datetime.to_s}0"))
  end
end