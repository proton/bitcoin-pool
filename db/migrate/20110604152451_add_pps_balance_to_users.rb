class AddPpsBalanceToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :price, :decimal,
      :precision => 16,
      :scale => 8,
      :default => 0
  end

  def self.down
    remove_column :users, :price
  end
end
