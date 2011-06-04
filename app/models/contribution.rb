class Contribution < ActiveRecord::Base
  belongs_to :block
  belongs_to :worker

  # Scopes contributions on confirmed blocks
  def self.confirmed(confirmed = true)
    if confirmed
      joins(:blocks).
        where("`blocks`.`confirmations` >= ?", 120)
    else
      all
    end
  end
end
