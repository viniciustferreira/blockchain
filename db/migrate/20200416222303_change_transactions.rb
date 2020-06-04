class ChangeTransactions < ActiveRecord::Migration[6.0]
  def change
    change_table :transactions do |t|
      t.remove :creation_date
      t.timestamps
    end
  end
end
