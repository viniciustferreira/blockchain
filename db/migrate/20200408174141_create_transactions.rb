class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.decimal :amount
      t.datetime :creation_date
      t.datetime :insertion_date
    end
  end
end
