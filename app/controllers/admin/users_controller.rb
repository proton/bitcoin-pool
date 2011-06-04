class Admin::UsersController < Admin::ApplicationController
  active_scaffold :user do |config|
    config.columns = [:nick, :email, :admin, :address, :confirmed_at, :last_sign_in_at, :sign_in_count, :current_sign_in_at, :current_sign_in_ip, :last_sign_in_at, :last_sign_in_ip]

    config.list.columns = [:nick, :email, :last_sign_in_at]

    config.nested.add_link :workers
  end
end
