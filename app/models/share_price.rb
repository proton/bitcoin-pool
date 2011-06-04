class SharePrice < ActiveRecord::Base
  validates :starts_at,
    :presence => true

  validates :ends_at,
    :presence => true

  validates :price,
    :presence => true,
    :inclusion => { :in => [0..50] }

  validate do
    if starts_at >= ends_at
      errors[:base].add t("errors.datetime_order")
    end
  end
end
