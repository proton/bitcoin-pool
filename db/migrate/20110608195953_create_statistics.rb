class CreateStatistics < ActiveRecord::Migration
  def self.up
    create_table :statistics do |t|
      t.string :metric, :null => false
      t.float :value, :null => false

      t.integer :worker_id
      t.integer :user_id

      t.datetime :recorded_at, :null => false
    end

    add_index :statistics, :recorded_at
  end

  def self.down
    drop_table :statistics
  end
end
