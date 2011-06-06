class CreateContributions < ActiveRecord::Migration
  def self.up
    create_table :contributions do |t|
      t.integer :block_id
      t.integer :worker_id

      t.decimal :score,
        :null => false,
        :precision => 16,
        :scale => 8,
        :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :contributions
  end
end
