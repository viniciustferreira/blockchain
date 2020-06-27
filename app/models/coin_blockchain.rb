class CoinBlockchain < GenericBlockchain
  attr_accessor :transactions
  before_create :initialize_blockchain

  def initialize_blockchain
    super
    self
  end

  def update_blockchain
    #atualizar o repositório
  end

  def mine_block
    return nil if transaction_list == ""
    create_first_block if CoinBlockchain.first.nil?

    Proc.new do |nonce|
      previous_hash = CoinBlockchain.last.block_hash
      new_hash = generate_new_hash(nonce, previous_hash)

      until is_hash_valid?(new_hash) do
        nonce += 1
        new_hash = generate_new_hash(nonce, previous_hash)
      end
      Transaction.mark_transactions_as_clear(transaction_list)
      CoinBlockchain.create({ nonce: nonce, previous_hash: previous_hash, block_type: "coin", block_hash: new_hash, transactions: transaction_list })
    end
  end

  private

  def generate_new_hash(nonce, previous_hash)
    Digest::SHA2.hexdigest("#{nonce}#{previous_hash}#{transaction_list}")
  end

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