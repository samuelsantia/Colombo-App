module ApplicationHelper
  
  # Return a title on a per-page basis
  def title
    base_title = "Colombo"
    @title.nil? ? base_title : "#{base_title} - #{@title}"
  end
end
