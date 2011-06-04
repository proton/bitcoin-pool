class AddAmountToContributions < ActiveRecord::Migration
  def self.up
    add_column :contributions, :amount, :decimal,
      :precision => 16,
      :scale => 8,
      :default => 0
  end

  def self.down
    remove_column :contributions, :amount
  end
end
