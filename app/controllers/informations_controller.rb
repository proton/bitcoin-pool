class InformationsController < ApplicationController
  skip_before_filter :authenticate_user!
  
  def welcome
  end
end
