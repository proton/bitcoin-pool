class AddPaymentTresholdToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :payment_treshold, :decimal,
      :precision => 16,
      :scale => 8,
      :default => 0
  end

  def self.down
    remove_column :users, :payment_treshold
  end
end
