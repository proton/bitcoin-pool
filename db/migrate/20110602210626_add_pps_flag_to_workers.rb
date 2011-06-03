class AddPpsFlagToWorkers < ActiveRecord::Migration
  def self.up
    add_column :workers, :pps, :boolean
  end

  def self.down
    remove_column :workers, :pps
  end
end
