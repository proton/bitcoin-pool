class CreateWorkers < ActiveRecord::Migration
  def self.up
    create_table :workers do |t|
      t.string :username, :limit => 128, :null => false
      t.string :password, :limit => 128, :null => false

      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :workers
  end
end
