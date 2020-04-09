
class GenericBlockchain < ApplicationRecord
  attr_accessor :optimal_validation, :log

  def initialize
    @log = []
    @optimal_validation = '0000'
    create_first_block
  end

  def update_blockchain(blocks)
    if self.size = blocks.length  
      log += "block is already updated" 
    else
      log += "block had to be updated" 
      GenericBlockchain.delete_all
      blocks.each do |block|
        GenericBlockchain.create(block)
      end
    end
  end

  def create_first_block
    if self.all == nil
      create(nonce: 1, creation_datetime: DateTime.now, previous_hash: "0", hash: Digest::SHA2.hexdigest("1#{first_creation_datetime}0"))
    end
  end

  def send_to_node(node, new_node)
    post "#{node}/add_node", params: { url: new_node.url, port: new_node.port }
  end

  # def broadcast_nodes
  #   Node.all.each do |node|
  #     send_to_node(node,node)
  #   end
  # end

  def mine_block
    nonce = 1
    creation_datetime = DateTime.now
    previous_hash = self.last
    good_nonce = false

    until good_nonce == true do 
      string_hash = Digest::SHA2.hexdigest("#{nonce}#{creation_datetime}#{previous_hash}")
      if is_hash_valid?(string_hash)
        good_nonce = true
        return create({ nonce: nonce, previous_hash: previous_hash, hash: string_hash, creation_datetime: creation_datetime })
      else
        nonce = nonce + 1
      end
    end
  end

  def is_block_valid?(block, previous_block)
    return false if block.previous_hash != previous_block.hash
    true
  end

  def is_blockchain_valid?
    blockchain = GenericBlockchain.all
    blockchain.each.with_index do |block, index|
      break if blockchain[index + 1] == nil
      return false if is_block_valid?(block[index+1], block) == false
    end
    true
  end

  private

  def is_hash_valid?(string_hash)
    return true if string_hash[0..optimal_validation.size - 1] == optimal_validation
    false 
  end
end
