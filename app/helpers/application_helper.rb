module ApplicationHelper
  
  # Return a title on a per-page basis
  def title
    base_title = "Colombo"
    @title.nil? ? base_title : "#{@title} - #{base_title}"
  end
end
