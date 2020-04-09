
class CoinBlockchain < GenericBlockchain
  attr_accessor :transactions

  def initialize
    super
    @transactions = transaction_list
  end

  def transaction_list
    @transactions ||= Transaction.twenty_most_valuable
      .map(&:to_s)
      .join(',') 
  end

  # def create_block(nonce, previous_hash, hash, creation_datetime, transactions)
  #   {
  #     nonce: nonce,
  #     timestamp: creation_datetime,
  #     previous_hash: previous_hash, 
  #     hash: hash, 
  #     transactions: transactions
  #   }
  # end

  def mine_block
    nonce = 1
    creation_datetime = DateTime.now
    previous_hash = self.last
    good_nonce = false

    until good_nonce == true do 
      hash = Digest::SHA2.hexdigest("#{nonce}#{creation_datetime}#{previous_hash}#{transactions}")
      if is_hash_valid?(hash)
        good_nonce = true
        return create({ nonce: nonce, previous_hash: previous_hash, hash: hash, creation_datetime: creation_datetime, transactions: transactions })
      else
        nonce = nonce + 1
      end
    end
  end
end