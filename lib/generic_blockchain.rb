
class GenericBlockchain
  attr_accessor :blockchain, :optimal_validation 

  def initialize
    @blockchain = []
    @optimal_validation = '0000'
    first_creation_datetime = DateTime.now
    first_hash = Digest::SHA2.hexdigest("1#{first_creation_datetime}0")
    @blockchain << create_block(1, "0", first_hash, first_creation_datetime)
  end

  def create_block(nonce, previous_hash, hash, creation_datetime)
    {
      nonce: nonce,
      creation_datetime: creation_datetime,
      previous_hash: previous_hash, 
      hash: hash 
    }
  end

  def mine_block
    nonce = 1
    creation_datetime = DateTime.now
    previous_hash = blockchain.last[:hash]
    good_nonce = false

    until good_nonce == true do 
      hash = Digest::SHA2.hexdigest("#{nonce}#{creation_datetime}#{previous_hash}")
      if is_hash_valid?(hash)
        good_nonce = true
        return blockchain << create_block(nonce, previous_hash, hash, creation_datetime)
      else
        nonce = nonce + 1
      end
    end
  end

  def is_block_valid?(block, previous_block)
    return false if block[:previous_hash] != previous_block[:hash]
    true
  end

  def is_blockchain_valid?
    blockchain.each.with_index do |block, idx|
      return true if idx == blockchain.length - 1 
      return false if is_block_valid?(blockchain[idx+1], blockchain[idx]) == false
    end
  end

  private

  def is_hash_valid?(hash)
    return true if hash[0..optimal_validation.size - 1] == optimal_validation
    false 
  end
end
