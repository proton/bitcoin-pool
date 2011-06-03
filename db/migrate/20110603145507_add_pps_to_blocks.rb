class AddPpsToBlocks < ActiveRecord::Migration
  def self.up
    add_column :blocks, :pps, :boolean
  end

  def self.down
    remove_column :blocks, :pps
  end
end
