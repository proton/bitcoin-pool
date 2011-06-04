class Setting < ActiveRecord::Base
  def self.get(setting)
    find_by_key(setting.to_s).value
  end
end
