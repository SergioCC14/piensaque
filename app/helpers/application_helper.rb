module ApplicationHelper

  def error404  
    render :file => ("public/404.html")
  end

  def error500
    render :file => ("public/500.html")  
  end
end
