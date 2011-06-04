class Admin::SettingsController < ApplicationController
  active_scaffold :setting do |config|
    config.columns = [:key, :value]
  end
end
