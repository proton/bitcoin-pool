class Admin::ApplicationController < ApplicationController
  before_filter :authorize_admin!

  def main
    
  end

  def authorize_admin!
    unless current_user.admin?
      redirect_to user_root_path,
        :alert => t("flash.dont_even")
    end
  end
end
