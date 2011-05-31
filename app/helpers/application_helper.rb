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
end
