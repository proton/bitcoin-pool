module InformationsHelper
  def jqchart_defaults
    {
      :legend => {
        :show => true
      },
      :axes => {
        :yaxis => {
          :tickOptions => {
            :formatString => "%d"
          },
          :min => 0
        },
        :xaxis => {
          :tickOptions => {
            :formatString => "%H:%M"
          },
          :tickInterval => "4 hours",
          :min => DateTime.now.advance(:days => -1).strftime("%Y-%m-%d %H:00:00"),
          :max => DateTime.now.strftime("%Y-%m-%d %H:00:00")
        }
      },
      :seriesDefaults => {
        :showMarker => false
      },
      :series => [
        {
          :label => "Server hashrate (Mh/s)",
          :color => "#FF8000"
        }
      ]
    }
  end
end
