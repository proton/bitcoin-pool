class AddOrphanFlagToBlocks < ActiveRecord::Migration
  def self.up
    add_column :blocks, :orphan, :boolean
  end

  def self.down
    remove_column :blocks, :orphan
  end
end
