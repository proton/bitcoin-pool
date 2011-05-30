class Worker < ActiveRecord::Base
  def self.recently_active(limit = DateTime.now.advance(:minutes => -10))
    where("EXISTS (SELECT * FROM `shares` WHERE `shares`.`username` = `workers`.`username` AND `shares`.`created_at` > ?)", limit).count
  end
end
