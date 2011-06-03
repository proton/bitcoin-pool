class CreatePayments < ActiveRecord::Migration
  def self.up
    create_table :payments do |t|
      t.decimal :amount,
        :null => false,
        :precision => 16,
        :scale => 8,
        :default => 0

      t.integer :user_id,
        :null => false

      t.string :address,
        :null => false

      t.string :transaction_id,
        :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :payments
  end
end
