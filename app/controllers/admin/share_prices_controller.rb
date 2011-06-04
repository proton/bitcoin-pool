class Admin::SharePricesController < ApplicationController
  active_scaffold :share_price do |config|
    config.columns = [:starts_at, :ends_at, :price]
  end
end
