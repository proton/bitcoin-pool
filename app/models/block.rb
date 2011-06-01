class Block < ActiveRecord::Base
  belongs_to :worker

  validates :number,
    :presence => true,
    :uniqueness => true

  validates :found_at,
    :presence => true

  validates :user_id,
    :presence => true

  validates :hash,
    :presence => true,
    :uniqueness => true

  def confirmed?
    confirmations >= 120
  end

  def self.update_all
    Share.where(:upstream_result => "Y").all.each do
      # TODO ...

    end
  end
end
