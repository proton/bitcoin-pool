class InformationsController < ApplicationController
  skip_before_filter :authenticate_user!
  
  def welcome
    @series = [[]]
    
    Statistic.global.all.each do |s|
      @series[0] << [s.recorded_at.strftime("%Y-%m-%d %H:%M:%S"), (s.value/1000000)]
    end
  end
end
