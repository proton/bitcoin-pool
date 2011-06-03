class Admin::WorkersController < Admin::ApplicationController
  active_scaffold :worker do |config|
    config.columns = [:user, :suffix, :password, :pps]

    config.columns[:user].form_ui = :select
  end
end
