class CreateNodes < ActiveRecord::Migration[6.0]
  def change
    create_table :nodes do |t|
      t.integer :port 
      t.string :url, uniq: true
      t.timestamps
    end
  end
end
