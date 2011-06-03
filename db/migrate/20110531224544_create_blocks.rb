class CreateBlocks < ActiveRecord::Migration
  def self.up
    create_table :blocks do |t|
      t.integer :number
      
      t.string :checksum,
        :null => false

      t.datetime  :found_at,
        :null => false

      t.decimal :generated,
        :null => false,
        :precision => 16,
        :scale => 8,
        :default => 0

      t.integer :share_id

      t.integer :confirmations,
        :default => 0
      
      t.timestamps
    end

    execute 'ALTER TABLE blocks ADD UNIQUE INDEX checksum_idx (checksum(255))'
  end

  def self.down
    drop_table :blocks
  end
end
