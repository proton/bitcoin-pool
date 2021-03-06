module ApplicationHelper
  def errors_for(model, options = {})
    render :partial => 'layouts/errors', :locals => {
      :model => model,
      :message => options[:message]
    }
  end
  
  def creation_link(resource, label)
    out = content_tag :div, :class => "creation-link" do
      link_to "#{image_tag("add.gif", :alt => label, :title => label)} #{label}".html_safe,
        send("new_#{resource}_path")
    end
    
    out << content_tag(:br)
    out
  end

  def format_hashrate(hashrate)
    number_to_human hashrate, :units => {
      :unit => "H/s",
      :thousand => "Kh/s",
      :million => "Mh/s",
      :billion => "Gh/s",
      :trillion => "Th/s",
      :quadrillion => "Ph/s"
    }
  end
  
  def format_bitcoin_address(address)
    testnet = Bitcoin::Client.instance.testnet? ? "testnet/" : ""
      
    content_tag :a,
      :title => address,
      :target => "_blank",
      :href => "http://blockexplorer.com/#{testnet}address/#{address}" do
      content_tag :span, :class => "address" do
        address
      end
    end
  end
end
