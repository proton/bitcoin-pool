class Worker < ActiveRecord::Base
  belongs_to :user,
    :foreign_key => "username"
  
  def self.recently_active(limit = DateTime.now.advance(:minutes => -10))
    where("EXISTS (SELECT * FROM `shares` WHERE `shares`.`username` = `workers`.`username` AND `shares`.`created_at` > ?)", limit).count
  end
end
