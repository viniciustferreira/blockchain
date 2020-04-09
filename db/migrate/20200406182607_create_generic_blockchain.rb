class CreateGenericBlockchain < ActiveRecord::Migration[6.0]
  def change
    create_table :generic_blockchains do |t|
      t.string :nonce
      t.string :previous_hash
      t.string :hash
      t.string :transactions
      t.timestamps
    end
  end
end
