class CreateSharePrices < ActiveRecord::Migration
  def self.up
    create_table :share_prices do |t|
      t.datetime :starts_at,
        :null => false

      t.datetime :ends_at,
        :null => false
      
      t.decimal :price,
        :precision => 16,
        :scale => 8,
        :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :share_prices
  end
end
