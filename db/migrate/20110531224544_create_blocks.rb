class CreateBlocks < ActiveRecord::Migration
  def self.up
    create_table :blocks do |t|
      t.integer :number
      
      t.text :checksum,
        :null => false,
        :length => 256

      t.datetime  :found_at,
        :null => false

      t.decimal :generated,
        :null => false,
        :precision => 16,
        :scale => 8,
        :default => 0

      t.integer :worker_id

      t.integer :confirmations,
        :default => 0
      
      t.timestamps
    end

    execute 'ALTER TABLE blocks ADD UNIQUE INDEX checksum_idx (checksum(256))'
  end

  def self.down
    drop_table :blocks
  end
end
