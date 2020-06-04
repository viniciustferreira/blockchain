class GenericBlockchain < ApplicationRecord
  attr_accessor :optimal_validation, :log
  before_create :initialize_blockchain

  def initialize_blockchain
    @log = []
    @optimal_validation = ENV['OPTIMAL_VALIDATION']
    # create_first_block if CoinBlockchain.first.nil?
  end

  def rewrite_blockchain(blocks)
    #sends a link with updated blockchain to all nodes
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
    if self.class.count == 0
      first_datetime = DateTime.now
      self.nonce = 1
      self.previous_hash = "0" 
      self.block_type = "generic" 
      self.block_hash =  Digest::SHA2.hexdigest("1#{first_datetime.to_s}0")
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

  def update_blockchain
    file = File.new("blockchain_v#{DateTime.now}", "w+")
    CoinBlockchain.all do |block|
      file.write("#{block.to_s}/n")
    end
    file.close
    #send to cloud repo
  end

  def mine_block
    nonce = 1
    previous_hash = self.class.last.hash
    good_nonce = false

    until good_nonce == true do 
      string_hash = Digest::SHA2.hexdigest("#{nonce}#{previous_hash}")
      if is_hash_valid?(string_hash)
        good_nonce = true
        return create({ nonce: nonce, previous_hash: previous_hash, block_hash: string_hash})
      else
        nonce = nonce + 1
      end
    end
  end

  def is_block_valid?(block, previous_block)
    return false if block.previous_hash != previous_block.block_hash
    true
  end

  def is_blockchain_valid?
    blockchain = self.class.all
    blockchain.each.with_index do |block, index|
      break if blockchain[index + 1] == nil
      return false if is_block_valid?(block[index+1], block) == false
    end
    true
  end

  def is_hash_valid?(string_hash)
    optimal_validation = ENV['OPTIMAL_VALIDATION']
    return true if string_hash[0..optimal_validation.size - 1] == optimal_validation
    false 
  end

  def to_s
    attributes = self.attributes
    attributes.except("id", "created_at", "updated_at").to_s
  end
end
