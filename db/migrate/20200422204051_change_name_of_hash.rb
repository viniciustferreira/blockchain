class ChangeNameOfHash < ActiveRecord::Migration[6.0]
  def change
    change_table :generic_blockchains do |t|
      t.remove :hash
      t.string :block_hash
    end
  end
end
