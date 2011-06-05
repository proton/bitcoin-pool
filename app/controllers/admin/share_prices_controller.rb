class Admin::SharePricesController < ApplicationController
  active_scaffold :share_price do |config|
    config.columns = [:starts_at, :ends_at, :price]

    config.columns[:starts_at].form_ui = :datepicker
    config.columns[:ends_at].form_ui = :datepicker
  end
end
