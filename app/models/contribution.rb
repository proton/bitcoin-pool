class Contribution < ActiveRecord::Base
  belongs_to :block
  belongs_to :worker

  # Scopes contributions on confirmed blocks
  def self.confirmed(confirmed = true)
    confirmations = (confirmed ? 120 : -1)
    
    joins(:block).
      where("`blocks`.`confirmations` >= ?", confirmations)
  end
end
