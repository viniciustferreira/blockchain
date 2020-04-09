class AddBlockTypetoGenericBlockchain < ActiveRecord::Migration[6.0]
  def change
    add_column :generic_blockchains, :block_type, :string 
  end
end
