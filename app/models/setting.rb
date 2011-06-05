class Setting < ActiveRecord::Base
  validates :key,
    :presence => true,
    :uniqueness => true

  validates :value,
    :presence => true

  def self.get(setting)
    find_by_key(setting.to_s).value
  end

  def label
    key
  end
end
