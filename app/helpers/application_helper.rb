module ApplicationHelper
  # dynamically include js or stylesheet includes from a view
  #http://media.railscasts.com/videos/088_dynamic_select_menus.mov
  def javascript(*files)
    content_for(:head) { javascript_include_tag(*files)}
  end

  def stylesheet(*files)
    content_for(:head) { stylesheet_link_tag(*files)}
  end

end
